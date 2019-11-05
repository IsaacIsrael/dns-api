require 'rails_helper'

RSpec.describe SearchDnsHostname, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(IP: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(IP: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(IP: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(IP: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(IP: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }
  describe '.call' do
    context 'when without params' do
      subject(:context) { SearchDnsHostname.call(page: 1) }
      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns2.dns, dns3.dns, dns4.dns, dns5.dns)
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'ipsum.com', 'dolor.com', 'amet.com','sit.com')
      end
      it 'return total' do
        expect(context.total).to equal 5
      end
    end
    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      subject(:context) { SearchDnsHostname.call(page: 1, filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns3.dns)
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'amet.com')
      end
      it 'return number of matching dns records' do
        expect(context.total).to equal 2
      end
    end
  end
end
