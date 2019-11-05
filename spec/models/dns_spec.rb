require 'rails_helper'

RSpec.describe Dns, type: :model do
  it 'should be valid with a IP' do
    dns = Dns.new(IP: '1.1.1.1')
    expect(dns).to be_valid
  end
  it 'is invalid without IP' do
    dns = FactoryBot.build(:dns, IP: nil)
    dns.valid?
    expect(dns.errors[:IP]).to include("can't be blank")
  end
  it 'is invalid duplicate IP' do
    FactoryBot.create(:dns, IP: '1.1.1.1')
    dns = FactoryBot.build(:dns, IP: '1.1.1.1')
    dns.valid?
    expect(dns.errors[:IP]).to include('has already been taken')
  end
  it 'is invalid if is not IPv4 format' do
    dns = FactoryBot.build(:dns, IP: '1000000.1000000.1000000.100000')
    dns.valid?
    expect(dns.errors[:IP]).to include('is not IPv4 format')
  end
end
