class SocialProfile < ApplicationRecord
  belongs_to :user

  def self.from_omniauth
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |profile|
      profile.token       = auth.info['token']
      profile.description = auth.info['description']
      profile.info        = auth.info.to_json if auth.info.present?
      profile.extra       = auth.extra.to_json if auth.extra.present?
      profile.credentials = auth.credentials.to_json if auth.credentials.present?
    end
  end
end
