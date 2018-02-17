FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "no#{n}" }
    password "password"
    password_confirmation "password"
    admin false
  end
end
