require 'rails_helper'

RSpec.describe SearchHostname, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostname.call(IP: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostname.call(IP: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostname.call(IP: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostname.call(IP: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostname.call(IP: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    context 'when without params' do
      let(:dns) { SearchDns.call.dns }
      subject(:context) { SearchHostname.call(dns: dns) }

      it 'succeeds'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
    context 'when given included filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
    context 'when given excluded filter' do
      let(:filter) { { excluded: ['sit.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
  end
end
