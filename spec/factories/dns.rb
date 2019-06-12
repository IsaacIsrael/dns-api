FactoryBot.define do
  factory :dn, class: 'Dns' do
    sequence(:IP) { |n| "#{n}.#{n}.#{n}.#{n}" }
  end
end
