FactoryGirl.define do
  factory :make do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:webmotors_id) { |n| n }
  end
end
