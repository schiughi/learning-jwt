class AuthenticateCommand < ApplicationCommand
  validates :username , presence: true
  validates :password , presence:true
  attr_reader :token

  private
  attr_reader :username , :password , :service

  def initialize(username: nil, password: nil, service: JwtService.new)
    @username = username
    @password = password
    @service = service
  end

  def call
    if unregistered_user?
      errors.add(:base, :unregistered_user)
    elsif password_invalid?
      errors.add(:base, :invalid_credentials)
    else
      @token = service.encode(contents)
    end
  end

  def user
    @user ||= User.find_by(username: username)
  end

  def unregistered_user?
    user.nil?
  end

  def password_invalid?
    not user.authenticate(password)
  end

  def contents
    {
      user_id: user.id ,
      expires: 24.hours.from_now.to_i
    }
  end
end
