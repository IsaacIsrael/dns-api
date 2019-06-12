class DnsHostname < ApplicationRecord
  belongs_to :dns
  belongs_to :hostname
end
