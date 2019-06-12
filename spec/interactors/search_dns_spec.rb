require 'rails_helper'

RSpec.describe SearchDns, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(ip: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(ip: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(ip: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    context 'when without params' do
      subject(:context) { SearchDns.call }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns2.dns, dns3.dns, dns4.dns, dns5.dns)
      end
    end
    context 'when given included filter' do
      let(:filter) { { included:['ipsum.com', 'dolor.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns3.dns, dns4.dns)
      end
      it 'not return other dns' do
        expect(context.dns).to_not include(dns2.dns, dns5.dns)
      end
    end
    context 'when given excluded filter' do
      let(:filter) { { excluded:['sit.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns2.dns, dns3.dns)
      end
      it 'return dns array with the exect number of dns' do
        expect(context.dns).to_not include(dns4.dns, dns5.dns)
      end
    end
    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return dns array ' do
        expect(context.dns).to include(dns1.dns, dns3.dns)
      end
      it 'not return other dns' do
        expect(context.dns).to_not include(dns4.dns, dns5.dns, dns2.dns)
      end
    end
  end
end
