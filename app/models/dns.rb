class Dns < ApplicationRecord
  validates :IP, presence: true, uniqueness: true
end
