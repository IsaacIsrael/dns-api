require 'rails_helper'

RSpec.describe AddHostnames, type: :interactor do
  describe '.call' do
    let(:dns) { FactoryBot.create(:dns) }
    context 'when given valid params' do
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { AddHostnames.call(params) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'save hostnames' do
        expect { context }.to change(Hostname.all, :count).by(3)
      end
      it 'link dns to hostname' do
        expect { context }.to change(dns.hostnames, :count).by(3)
      end
    end
    context 'when given exist hostname' do
      let!(:hostname) { FactoryBot.create(:hostname, name: 'lorem.com') }
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'ipsum.com', 'amet.com'] } }
      subject(:context) { AddHostnames.call(params) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'dont save duplecate hostnames' do
        expect { context }.to change(Hostname.all, :count).by(2)
      end
      it 'link dns to hostname' do
        expect { context }.to change(dns.hostnames, :count).by(3)
      end
    end
    context 'when given duplicate hostname' do
      let(:params) { { dns: dns, hostnames: ['lorem.com', 'lorem.com', 'amet.com'] } }
      subject(:context) { AddHostnames.call(params) }

      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save any hostnames' do
        expect { context }.to_not change(Hostname.all, :count)
      end
      it 'dont link dns to hostname' do
        expect { context }.to_not change(dns.hostnames, :count)
      end
    end
    context 'when given invalid hostname' do
      let(:params) { { dns: dns, hostnames: [nil, 'lorem.com', 'amet.com'] } }
      subject(:context) { AddHostnames.call(params) }

      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save any hostnames' do
        expect { context }.to_not change(Hostname.all, :count)
      end
      it 'dont link dns to hostname' do
        expect { context }.to_not change(dns.hostnames, :count)
      end
    end
    context 'when not given  hostname' do
      let(:params) { { dns: dns } }
      subject(:context) { AddHostnames.call(params) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end
    context 'when given invalid hostname type' do
      let(:params) { { dns: dns, hostnames: 'hostname' } }
      subject(:context) { AddHostnames.call(params) }

      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save any hostnames' do
        expect { context }.to_not change(Hostname.all, :count)
      end
      it 'dont link dns to hostname' do
        expect { context }.to_not change(dns.hostnames, :count)
      end
    end
  end
end
