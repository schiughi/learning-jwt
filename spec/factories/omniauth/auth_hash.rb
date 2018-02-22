FactoryBot.define do
  factory :auth_hash, class: 'OmniAuth::AuthHash' do
    provider "slack"
    uid "U3BPA937E"
    info
    credentials
    extra
  end

  factory :info , class: 'OmniAuth::AuthHash::InfoHash' do
    description "Welcome to Slack"
    email "email@example.com"
    first_name "Matt"
    image "https://secure.gravatar.com/avatar/69720796ae3e1c2d63cd66b2d53571a5.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0013-192.png"
    image_24 "https://secure.gravatar.com/avatar/69720796ae3e1c2d63cd66b2d53571a5.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0013-24.png"
    image_48 "https://secure.gravatar.com/avatar/69720796ae3e1c2d63cd66b2d53571a5.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0013-48.png"
    is_admin true
    is_owner true
    last_name "Holmes"
    name "Matt Holmes"
    nickname "matty"
    team "Mattison co."
    team_id "A3V3VC35Y"
    time_zone "Europe/Amsterdam"
    user "matty"
    user_id "U3BPA937E"
  end

  factory :credentials , class: 'OmniAuth::AuthHash' do
    expires false
    token "xoxp-127131411201-127810174082-127813170226-f205827fb956488602bef2068471d7a5"
  end

  factory :extra , class: 'OmniAuth::AuthHash' do
    raw_info
  end

  factory :raw_info , class: 'OmniAuth::AuthHash' do
    ok true
    team "Mattison co."
    team_id "A3V3VC35Y"
    url "https://mattison.slack.com/"
    user "matty"
    user_id "U3BPA937E"
  end
end
