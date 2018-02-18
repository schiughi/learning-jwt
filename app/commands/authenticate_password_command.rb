class AuthenticatePasswordCommand < ApplicationCommand
  validates :username , presence: true
  validates :password , presence:true
  validate :password_must_correspond_with_users

  attr_reader :token

  private
  attr_reader :username , :password , :service

  def initialize(username: nil, password: nil, service: JwtService.new)
    @username = username
    @password = password
    @service = service
  end

  def call
    @token = service.encode(contents)
  end

  def contents
    {
      user_id: user.id ,
      exp: 24.hours.from_now.to_i
    }
  end

  def password_must_correspond_with_users
    unless user.present?
      return errors.add(:base, :unregistered_user)
    end

    unless user.authenticate(password)
      errors.add(:base, :invalid_credentials)
    end
  end

  def user
    @user ||= User.find_by(username: username)
  end
end
