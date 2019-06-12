require 'rails_helper'

RSpec.describe SearchDns, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostname.call(ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostname.call(ip: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostname.call(ip: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostname.call(ip: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostname.call(ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    context 'when without params' do
      subject(:context) { SearchDns.call }

      it 'succeeds'
      it 'return dns array'
    end
    context 'when given included filter' do
      let(:filter) { { included:['ipsum.com', 'dolor.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds'
      it 'return dns array'
      it 'not return other dns'
    end
    context 'when given excluded filter' do
      let(:filter) { { excluded:['sit.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds'
      it 'return dns array'
      it 'not return other dns'
    end
    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      subject(:context) { SearchDns.call(filter: filter) }

      it 'succeeds'
      it 'return dns array'
      it 'not return other dns'
    end
  end
end
