module JwtService
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
    end

    def decode(token)
      result = JWT.decode(token,
                          Rails.application.secrets.secret_key_base,
                          true,
                          { algorithm: 'HS256' })
                  .first
      HashWithIndifferentAccess.new(result)
    rescue JWT::ExpiredSignature
      nil
    end
  end
end
