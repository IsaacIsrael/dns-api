# Hostname Model
class Hostname < ApplicationRecord
  has_many :dns_hostname
  has_many :dns, through: :dns_hostname

  validates :name,
            presence: true,
            uniqueness: true
end
