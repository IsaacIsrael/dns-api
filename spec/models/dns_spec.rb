require 'rails_helper'

RSpec.describe Dns, type: :model do
  it 'should be valid with a IP'
  it 'is invalid without IP'
  it 'is invalid duplicate IP'
  it 'is invalid if is not IPv4 format'
end
