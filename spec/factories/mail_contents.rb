FactoryGirl.define do
  factory :mail_content do |f|

    f.html_content { Faker::Lorem.paragraphs(3) }
    f.text_content { Faker::Lorem.paragraphs(3) }

    f.campaign strategy: :build

  end
end
