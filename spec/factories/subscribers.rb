FactoryGirl.define do
  factory :subscriber do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.is_active true
    f.bounce_count 0
    f.bounce_comments ""

    f.subscription_list strategy: :build

  end
end
