class Dns < ApplicationRecord
  validates :IP, presence: true
end
