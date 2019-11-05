require 'rails_helper'

RSpec.describe CreateDnsWithHostnames, type: :interactor do
  describe '.call' do
    context 'when given valid params' do
      let(:params) { { IP: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostnames.call(params) }
      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'save dns' do
        expect { context }.to change(Dns.all, :count).by(1)
      end
      it 'save hostnames' do
        expect { context }.to change(Hostname.all, :count).by(3)
      end
    end
    context 'when given invalid dns' do
      let(:params) { { IP: nil, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostnames.call(params) }
      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save dns' do
        expect { context }.to_not change(Dns.all, :count)
      end
      it 'dont save hostnames' do
        expect { context }.to_not change(Hostname.all, :count)
      end
    end
    context 'when given invalid hostname' do
      let(:params) { { IP: '1.1.1.1', hostnames: ['lorem.com', 'lorem.com', 'amet.com'] } }
      subject(:context) { CreateDnsWithHostnames.call(params) }
      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save dns' do
        expect { context }.to_not change(Dns.all, :count)
      end
      it 'dont save hostnames' do
        expect { context }.to_not change(Hostname.all, :count)
      end
    end
  end
end
