require 'resolv'

# DNS model
class Dns < ApplicationRecord
  include Filterable

  has_many :dns_hostname
  has_many :hostnames, through: :dns_hostname

  validates :IP,
            presence: true,
            uniqueness: true,
            format: { with: Resolv::IPv4::Regex, message: 'is not IPv4 format' }

  scope :included, ->(hostnames) {
    where(id: Dns.select('id')
              .joins(:hostnames)
              .where('hostnames.name in (?)', hostnames)
              .group(:id)
              .having('COUNT(dns.id) = ?', hostnames.count))
  }

  scope :excluded, ->(hostnames) {
    where.not(id: Dns.select('id')
              .joins(:hostnames)
              .where('hostnames.name in (?)', hostnames)
              .uniq)
  }
end
