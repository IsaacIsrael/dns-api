require 'rails_helper'

RSpec.describe CreateDns, type: :interactor do
  describe '.call' do
    context 'when given valid dns' do
      let(:params) { FactoryBot.attributes_for(:dns) }
      subject(:context) { CreateDns.call(params) }
      it 'succeeds'
      it 'save dns'
    end
    context 'when given invalid dns' do
      it 'fails'
      it 'dont save dns'
    end
  end
end
