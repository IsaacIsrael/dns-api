require 'resolv'

# DNS model
class Dns < ApplicationRecord
  validates :IP,
            presence: true,
            uniqueness: true,
            format: { with: Resolv::IPv4::Regex, message: 'is not IPv4 format' }
end
