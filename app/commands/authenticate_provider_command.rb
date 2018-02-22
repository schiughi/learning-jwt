class AuthenticateProviderCommand < ApplicationCommand
  validates :auth, presence: true
  validate :auth_hash_value_is_filled
  attr_reader :token

  private
  attr_reader :auth , :service

  def initialize(auth, service: JwtService.new)
    @auth = auth
    @service = service
  end

  def call
    register_profile
    encode_token
  end

  def register_profile
    user.social_profiles.from_omniauth(auth) unless social_profile.present?
  end

  def social_profile
    @social_profile ||= SocialProfile.find_by(provider: auth.provider, uid: auth.uid)
  end

  def user
    @user ||= social_profile.try(:user)
    @user ||= User.create_provisional_account(auth.info['nickname'])
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

  def auth_hash_value_is_filled
    return errors.add(:auth, :invalid) unless auth && auth.credentials.token.present?
    return errors.add(:auth, :invalid) unless auth && auth.info['nickname'].present?
  end
end
