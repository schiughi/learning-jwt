class DecodeAuthenticationCommand < ApplicationCommand
  validate :token_is_able_to_decode

  attr_reader :user

  private
  attr_reader :authorization , :service

  def initialize(headers, service: JwtService.new)
    @authorization = headers['Authorization'] if headers.present?
    @service = service
  end

  def call
    @user = User.find_by(id: user_id)
  end

  def user_id
    contents[:user_id]
  end

  def contents
    @contents ||= service.decode(token)
  end

  def token
    authorization.split(/\s/)[1] if authorization.present?
  end

  def token_is_able_to_decode
    return errors.add(:token, :token_missing) unless authorization
    return errors.add(:token, :token_missing) unless token
    return errors.add(:token, :token_expired) unless contents
    return errors.add(:token, :token_invalid) unless user_id
  end
end
