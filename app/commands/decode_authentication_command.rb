class DecodeAuthenticationCommand < ApplicationCommand
  validate :token_is_able_to_decode

  attr_reader :user

  def error_message
    errors.full_messages.first
  end

  private
  attr_reader :token , :service

  def initialize(token, service: JwtService.new)
    @token = token
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

  def token_is_able_to_decode
    return errors.add(:token, :token_missing) unless token
    return errors.add(:token, :token_expired) unless contents
    return errors.add(:token, :token_invalid) unless user_id
  end
end
