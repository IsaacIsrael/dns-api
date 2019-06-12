require 'resolv'

# DNS model
class Dns < ApplicationRecord
  has_many :dns_hostname
  has_many :hostnames, through: :dns_hostname

  validates :IP,
            presence: true,
            uniqueness: true,
            format: { with: Resolv::IPv4::Regex, message: 'is not IPv4 format' }
end
