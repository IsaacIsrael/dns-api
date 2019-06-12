require 'rails_helper'

RSpec.describe Hostname, type: :model do
  it 'should be valid with a name' do
    hostname = Hostname.new(name: 'ipsum.com')
    expect(hostname).to be_valid
  end
  it 'is invalid without name' do
    hostname = FactoryBot.build(:hostname, name: nil)
    hostname.valid?
    expect(hostname.errors[:name]).to include("can't be blank")
  end
  it 'is invalid duplicate name' do
    FactoryBot.create(:hostname, name: 'ipsum.com')
    hostname = FactoryBot.build(:hostname, name: 'ipsum.com')
    hostname.valid?
    expect(hostname.errors[:name]).to include('has already been taken')
  end
end
