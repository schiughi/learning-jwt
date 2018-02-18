FactoryBot.define do
  factory :social_profile do
    user nil
    provider "MyString"
    uid "MyString"
    token "MyString"
    description "MyText"
    info ""
    extra ""
    credentials ""
  end
end
