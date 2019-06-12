require 'rails_helper'

RSpec.describe "ApiV1Dns", type: :request do
  describe 'POST /api_v1_dns' do
    context 'when given valid params' do
      it 'have http status 201'
      it 'return dns created id'
      it 'create a dns'
      it 'create hostnames'
    end
    context 'when  not given dns' do
      it 'have http status 400'
      it 'return error'
      it 'not create a dns'
      it 'not create hostnames'
    end
    context 'when given invalid hostnames' do
      it 'have http status 400'
      it 'return error'
      it 'not create a dns'
      it 'not create hostnames'
    end
  end
end
