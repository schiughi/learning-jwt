class AuthenticateCommand < ApplicationCommand
  validates :username , presence: true
  validates :password , presence:true
  validate :user_must_be_registered
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

  def user_must_be_registered
    if user.nil?
      errors.add(:base, :unregistered_user)
    end
  end

  def password_must_correspond_with_users
    unless user.present? && user.authenticate(password)
      errors.add(:base, :invalid_credentials)
    end
  end

  def user
    @user ||= User.find_by(username: username)
  end
end
