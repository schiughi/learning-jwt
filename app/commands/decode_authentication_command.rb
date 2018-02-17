class DecodeAuthenticationCommand < ApplicationCommand
  validates :authorization , presence: true

  attr_reader :user

  private
  attr_reader :authorization , :service

  def initialize(headers, service: JwtService.new)
    @authorization = headers['Authorization']
    @service = service
  end

  def call
    return errors.add(:token, :token_missing) if token.nil?
    return errors.add(:token, :token_expired) if contents.nil?
    return errors.add(:token, :token_invalid) if user_id.nil?
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def user_id
    contents[:user_id]
  end

  def contents
    @contents ||= service.decode(token)
  end

  # authorization: e.g. "base xxxxxxxxxxxxxxxxxxxxxx"
  # return "xxxxxxxxxxxxxxxxxxx"
  def token
    authorization.split(/\s/)[1]
  end
end
