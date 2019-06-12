class DnsHostname < ApplicationRecord
  belongs_to :dns
  belongs_to :hostname

  validates :dns_id, uniqueness: { scope: :hostname_id }
end
