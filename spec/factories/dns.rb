FactoryBot.define do
  factory :dns, class: 'Dns' do
    sequence(:IP) { |n| "#{n}.#{n}.#{n}.#{n}" }
  end
end
