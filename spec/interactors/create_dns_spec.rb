require 'rails_helper'

RSpec.describe CreateDns, type: :interactor do
  describe '.call' do
    context 'when given valid dns' do
      let(:params) { FactoryBot.attributes_for(:dns) }
      subject(:context) { CreateDns.call(params) }
      it 'success' do
        expect(context).to be_a_success
      end
      it 'save dns' do
        expect { context }.to change(Dns.all, :count).by(1)
      end
    end
    context 'when given invalid dns' do
      it 'fails' do
        expect(context).to be_a_failure
      end
      it 'dont save dns' do
        expect { context }.to_not change(Dns.all, :count)
      end
    end
  end
end
