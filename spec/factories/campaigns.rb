require 'faker'

FactoryGirl.define do
  factory :campaign do |f|
    f.name { Faker::Name.name }
    f.subject { Faker::Lorem.sentence }
    f.from_email { Faker::Internet.email }
    f.from_name { Faker::Name.name }
    f.reply_to { Faker::Internet.email }
    f.status "draft"
  end
end
