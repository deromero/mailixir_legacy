require 'faker'

FactoryGirl.define do
  factory :client do |f|
    f.name { Faker::Name.name }
    f.description { Faker::Lorem.sentence }
  end
end
