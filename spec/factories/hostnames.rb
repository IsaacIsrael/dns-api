FactoryBot.define do
  factory :hostname do
    sequence(:name) { |n| "hostname#{n}.com" }
  end
end
