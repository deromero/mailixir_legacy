FactoryGirl.define do
  factory :subscription_list do |f|
    f.name { Faker::Name.name }
    f.list_type "flat"

    f.client strategy: :build
  end
end
