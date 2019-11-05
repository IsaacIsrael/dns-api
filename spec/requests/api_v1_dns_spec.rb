require 'rails_helper'

RSpec.describe "ApiV1Dns", type: :request do
  describe 'POST /api_v1_dns' do
    context 'when given valid params' do
      let(:ip) { FactoryBot.attributes_for(:dns)[:IP] }
      let(:hostnames) { Array.new(5).map { FactoryBot.attributes_for(:hostname)[:name] } }
      let(:dns_parameters) { { IP: ip, hostnames: hostnames } }
      subject(:call) { post api_v1_dns_path, params: dns_parameters }

      it 'have http status 201' do
        call
        expect(response).to have_http_status(201)
      end
      it 'return dns created id' do
        call
        expect(JSON.parse(response.body)).to include('id')
      end
      it 'create a dns' do
        expect { call }.to change(Dns.all, :count).by(1)
      end
      it 'create hostnames' do
        expect { call }.to change(Hostname.all, :count).by(5)
      end
    end
    context 'when  not given dns' do
      let(:hostnames) { Array.new(5).map { FactoryBot.attributes_for(:hostname)[:name] } }
      let(:dns_parameters) { { hostnames: hostnames } }
      subject(:call) { post api_v1_dns_path, params: dns_parameters }

      it 'have http status 400' do
        call
        expect(response).to have_http_status(400)
      end
      it 'return error' do
        call
        expect(JSON.parse(response.body)).to include('error')
      end
      it 'not create a dns' do
        expect { call }.to_not change(Dns.all, :count)
      end
      it 'not create hostnames' do
        expect { call }.to_not change(Hostname.all, :count)
      end
    end
    context 'when given invalid hostnames' do
      let(:ip) { FactoryBot.attributes_for(:dns)[:IP] }
      let(:hostnames) { ['lorem.com', 'lorem.com'] }
      let(:dns_parameters) { { IP: ip, hostnames: hostnames } }
      subject(:call) { post api_v1_dns_path, params: dns_parameters }

      it 'have http status 400' do
        call
        expect(response).to have_http_status(400)
      end
      it 'return error' do
        call
        expect(JSON.parse(response.body)).to include('error')
      end
      it 'not create a dns' do
        expect { call }.to_not change(Dns.all, :count)
      end
      it 'not create hostnames' do
        expect { call }.to_not change(Hostname.all, :count)
      end
    end
  end

  describe 'GET /api_v1_dns' do
    context 'when given valid params' do
      let(:page) { 1 }
      let(:included) { ['ipsum.com', 'dolor.com'] }
      let(:excluded) { ['sit.com'] }
      subject(:call) { get api_v1_dns_path, params: { page: page, included: included, excluded: excluded } }

      it 'have http status 200' do
        call
        expect(response).to have_http_status(200)
      end
      it 'return dns array' do
        call
        expect(JSON.parse(response.body)).to include('dns')
      end
      it 'return hostname array' do
        call
        expect(JSON.parse(response.body)).to include('hostnames')
      end
      it 'return total' do
        call
        expect(JSON.parse(response.body)).to include('total')
      end
    end
    context 'when given invalid params' do
      let(:included) { ['ipsum.com', 'dolor.com'] }
      let(:excluded) { ['sit.com'] }
      subject(:call) { get api_v1_dns_path, params: { included: included, excluded: excluded } }

      it 'have http status 400' do
        call
        expect(response).to have_http_status(400)
      end
      it 'return error' do
        call
        expect(JSON.parse(response.body)).to include('error')
      end
    end
  end
end
