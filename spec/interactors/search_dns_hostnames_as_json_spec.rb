require 'rails_helper'

RSpec.describe SearchDnsHostnamesAsJson, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(ip: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(ip: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(ip: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(ip: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] }}
    let(:dns) { SearchDns.call(filter: filter).dns }
    let(:hostnames) { SearchHostname.call(dns: dns,filter: filter).hostnames }
    let(:per_page) {FilterDnsHostnamesPerPage.call(page: 2, limit: 1, dns: dns, hostnames: hostnames) }
    subject(:context) {SearchDnsHostnamesAsJson.call(total: per_page.total, dns: per_page.dns, hostnames: per_page.hostnames) }

    it 'succeeds' do
      expect(context).to be_a_success
    end
    it 'return total' do
      expect(context.response).to include('total')
    end
    it 'return  dns' do
      expect(context.response).to include('dns')
    end
    it 'return  hostnames' do
      expect(context.response).to include('hostnames')
    end
  end
end
