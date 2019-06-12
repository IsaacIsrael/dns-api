require 'rails_helper'

RSpec.describe CreateDnsWithHostnames, type: :interactor do
  describe '.call' do
    context 'when given valid params' do
      let(:params) { { ip: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostname.call(params) }
      it 'succeeds'
      it 'save dns'
      it 'save hostnames'
    end
    context 'when given invalid dns' do
      let(:params) { { ip: nil, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostname.call(params) }
      it 'fails'
      it 'dont save dns'
      it 'dont save hostnames'
    end
    context 'when given invalid hostname' do
      let(:params) { { ip: '1.1.1.1', hostnames: ['lorem.com', 'lorem.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostname.call(params) }
      it 'fails'
      it 'dont save dns'
      it 'dont save hostnames'
    end
  end
end
