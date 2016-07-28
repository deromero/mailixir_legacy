FactoryGirl.define do
  factory :recipient do
    name "MyString"
    email "MyString"
    comments "MyString"
    click_count ""
    click_on "2016-07-20 09:17:25"
    dsn "MyText"
    open_count ""
    open_on "2016-07-20 09:17:25"
    sent_on "2016-07-20 09:17:25"
    bounce_on "2016-07-20 09:17:25"
    was_clicked false
    was_opened false
    was_sent false
    was_failed false
    was_parsed false
    parsed_on "2016-07-20 09:17:25"
  end
end
