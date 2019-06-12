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
      subject(:context) {SearchDnsWithHostnamePerPage.call(page: 2, limit: 1, dns: dns, hostnames: hostnames) }

      it 'succeeds'
      it 'return total'
      it 'return filtered dns'
      it 'not return dns'
      it 'return filtered hostnames'
      it 'not return filtered hostnames'
      it 'return number of matching dns records'
    end
    context 'when given filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] }}
      let(:dns) { SearchDns.call(filter: filter).dns }
      let(:hostnames) { SearchHostname.call(dns: dns,filter: filter).hostnames }
      subject(:context) {SearchDnsWithHostnamePerPage.call(page: 2, limit: 1, dns: dns, hostnames: hostnames) }

      it 'succeeds'
      it 'return total'
      it 'return filtered dns'
      it 'not return dns'
      it 'return filtered hostnames'
      it 'not return filtered hostnames'
      it 'return number of matching dns records'
    end
  end
end
