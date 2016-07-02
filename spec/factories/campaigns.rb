require 'faker'

FactoryGirl.define do
  factory :campaign do |f|
    f.name { Faker::Name.name }
    f.description { Faker::Lorem.sentence }
  end
end
