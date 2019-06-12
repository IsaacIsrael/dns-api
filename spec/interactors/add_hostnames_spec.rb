require 'rails_helper'

RSpec.describe AddHostnames, type: :interactor do
  describe '.call' do
    let(:dns) { FactoryBot.create(:dns) }
    context 'when given valid params' do
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { AddHostname.call(params) }

      it 'success'
      it 'save hostnames'
      it 'link dns to hostname'
    end
    context 'when given exist hostname' do
      let!(:hostname) { FactoryBot.create(:hostname, name: 'lorem.com') }
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { AddHostname.call(params) }

      it 'success'
      it 'dont save duplecate hostnames'
      it 'link dns to hostname'
    end
    context 'when given duplicate hostname' do
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'lorem.com', 'amet.com'] } }
      subject(:context) { AddHostname.call(params) }

      it 'fails'
      it 'dont save any hostnames'
      it 'dont link dns to hostname'
    end
    context 'when given invalid hostname' do
      let(:params) { { dns: dns, hostnames: [nil, 'lorem.com', 'amet.com'] } }
      subject(:context) { AddHostname.call(params) }

      it 'fails'
      it 'dont save any hostnames'
      it 'dont link dns to hostname'
    end
    context 'when not given  hostname' do
      let(:params) { { dns: dns } }
      subject(:context) { AddHostname.call(params) }

      it 'success'
    end
    context 'when given invalid hostname type' do
      let(:params) { { dns: dns, hostnames: 'hostname' } }
      subject(:context) { AddHostname.call(params) }

      it 'fails'
      it 'dont save any hostnames'
      it 'dont link dns to hostname'
    end
  end
end
