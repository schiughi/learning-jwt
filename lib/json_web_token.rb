require 'jwt'

class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base)
      rescue 
         raise InvalidTokenError
      end
    end
  end
end

class InvalidTokenError < StandardError; end;