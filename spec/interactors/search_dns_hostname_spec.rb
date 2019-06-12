require 'rails_helper'

RSpec.describe SearchDnsHostname, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(ip: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(ip: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(ip: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }
  describe '.call' do
    context 'when without params' do
      subject(:context) { SearchDnsHostname.call(page: 1) }
      it 'succeeds'
      it 'return dns array'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      subject(:context) { SearchDnsHostname.call(page: 1, filter: filter) }
      it 'succeeds'
      it 'return dns array'
      it 'return hostname array for matching dns records'
      it 'return number of matching dns records'
    end
  end
end
