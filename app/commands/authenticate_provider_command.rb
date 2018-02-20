class AuthenticateProviderCommand < ApplicationCommand
  validates :auth, presence: true
  validate :access_token_required
  validate :user_name_required
  attr_reader :token

  private
  attr_reader :auth , :service

  def initialize(auth, service: JwtService.new)
    @auth = auth
    @service = service
  end

  def call
    register_profile unless social_profile.present?
    encode_token
  end

  def social_profile
    @social_profile ||= SocialProfile.find_by(provider: auth.provider, uid: auth.uid)
  end

  def register_profile
    user.social_profiles.from_omniauth(auth)
  end

  def user
    @user ||= social_profile.try(:user)
    @user ||= User.create_provisional_account(auth_name)
  end

  def auth_name
    auth.info['nickname'] || auth.info['name']
  end

  def encode_token
    @token = service.encode(contents)
  end

  def contents
    {
      user_id: user.id ,
      exp: 24.hours.from_now.to_i
    }
  end

  def access_token_required
    unless auth && auth_token.present?
      errors.add(:token, :token_missing)
    end
  end

  def user_name_required
    unless auth && auth_name.present?
      errors.add(:name, :name_invalid)
    end
  end
end
