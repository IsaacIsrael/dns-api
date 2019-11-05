require 'rails_helper'

RSpec.describe FilterDnsHostnamesPerPage, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(IP: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(IP: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(IP: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(IP: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(IP: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    context 'when without params' do
      let(:dns) { SearchDns.call.dns }
      let(:hostnames) { SearchHostname.call(dns: dns).hostnames }
      subject(:context) {FilterDnsHostnamesPerPage.call(page: 2, limit: 1, dns: dns, hostnames: hostnames) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return total' do
        expect(context.total).to be_kind_of(Numeric)
      end
      it 'return filtered dns' do
        expect(context.dns).to include(dns2.dns)
      end
      it 'not return dns' do
        expect(context.dns).to_not include(dns1.dns, dns3.dns, dns4.dns, dns5.dns)
      end
      it 'return filtered hostnames' do
        expect(context.hostnames.map(&:name)).to include('ipsum.com')
      end
      it 'not return filtered hostnames' do
        expect(context.hostnames.map(&:name)).to_not include('lorem.com', 'sit.com', 'dolor.com', 'amet.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [4]
      end
    end
    context 'when given filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] }}
      let(:dns) { SearchDns.call(filter: filter).dns }
      let(:hostnames) { SearchHostname.call(dns: dns,filter: filter).hostnames }
      subject(:context) {FilterDnsHostnamesPerPage.call(page: 2, limit: 1, dns: dns, hostnames: hostnames) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return total' do
        expect(context.total).to be_kind_of(Numeric)
      end
      it 'return filtered dns' do
        expect(context.dns).to include(dns3.dns)
      end
      it 'not return dns' do
        expect(context.dns).to_not include(dns1.dns, dns2.dns, dns4.dns, dns5.dns)
      end
      it 'return filtered hostnames' do
        expect(context.hostnames.map(&:name)).to include('amet.com')
      end
      it 'not return filtered hostnames' do
        expect(context.hostnames.map(&:name)).to_not include('ipsum.com', 'dolor.com', 'sit.com', 'lorem.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [2]
      end
    end
  end
end
