require 'faker'

FactoryGirl.define do
  factory :client do |f|
    f.name { Faker::Company.name }
    f.contact_name { Faker::Name.name }
    f.contact_email { Faker::Internet.email }
    f.country_code { Faker::Address.country_code }
    f.time_zone { -5 }


  end
end
