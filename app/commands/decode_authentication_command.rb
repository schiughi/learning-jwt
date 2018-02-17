class DecodeAuthenticationCommand < ApplicationCommand
  validate :token_is_able_to_decode

  attr_reader :user

  private
  attr_reader :authorization , :service

  def initialize(headers, service: JwtService.new)
    @authorization = headers['Authorization']
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

  # authorization: "#{key} #{token}"
  #    e.g. "base xgtstewtgsaee"
  # you can't use 'Enumerable#last' to 'authorization.split(/\s/)',
  # because this passes the key to service
  # and 'JWT::DecodeError: Not enough or too many segments' occurred on service
  # when authorization is key only.
  def token
    authorization.split(/\s/)[1]
  end

  def token_is_able_to_decode
    if authorization.nil? || token.nil?
      return errors.add(:token, :token_missing)
    end
    return errors.add(:token, :token_expired) if contents.nil?
    return errors.add(:token, :token_invalid) if user_id.nil?
  end
end
