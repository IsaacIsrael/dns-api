require 'rails_helper'

RSpec.describe SearchHostname, type: :interactor do
  let!(:dns1) {  CreateDnsWithHostnames.call(IP: '1.1.1.1', hostnames: ['lorem.com', 'ipsum.com', 'dolor.com', 'amet.com']) }
  let!(:dns2) {  CreateDnsWithHostnames.call(IP: '2.2.2.2', hostnames: ['ipsum.com']) }
  let!(:dns3) {  CreateDnsWithHostnames.call(IP: '3.3.3.3', hostnames: ['dolor.com', 'ipsum.com', 'amet.com']) }
  let!(:dns4) {  CreateDnsWithHostnames.call(IP: '4.4.4.4', hostnames: ['dolor.com', 'ipsum.com', 'sit.com', 'amet.com']) }
  let!(:dns5) {  CreateDnsWithHostnames.call(IP: '5.5.5.5', hostnames: ['dolor.com', 'sit.com']) }

  describe '.call' do
    context 'when without params' do
      let(:dns) { SearchDns.call.dns }
      subject(:context) { SearchHostname.call(dns: dns) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'ipsum.com', 'dolor.com', 'amet.com','sit.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [1, 2, 3, 4, 4]
      end
    end

    context 'when given included filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'sit.com', 'amet.com')
      end
      it 'not return other hostname for matching dns records' do
        expect(context.hostnames.map(&:name)).to_not include('ipsum.com', 'dolor.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [1, 1, 3]
      end
    end

    context 'when given excluded filter' do
      let(:filter) { { excluded: ['sit.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'ipsum.com', 'dolor.com', 'amet.com')
      end
      it 'not return other hostname for matching dns records' do
        expect(context.hostnames.map(&:name)).to_not include('sit.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [1, 2, 2, 3]
      end
    end

    context 'when given included and excluded filter' do
      let(:filter) { { included: ['ipsum.com', 'dolor.com'], excluded: ['sit.com'] } }
      let(:dns) { SearchDns.call(filter: filter).dns }
      subject(:context) { SearchHostname.call(dns: dns, filter: filter) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
      it 'return hostname array for matching dns records' do
        expect(context.hostnames.map(&:name)).to include('lorem.com', 'amet.com')
      end
      it 'not return other hostname for matching dns records' do
        expect(context.hostnames.map(&:name)).to_not include('ipsum.com', 'dolor.com', 'sit.com')
      end
      it 'return number of matching dns records' do
        expect(context.hostnames.map(&:match).sort).to eq [1, 2]
      end
    end
  end
end
