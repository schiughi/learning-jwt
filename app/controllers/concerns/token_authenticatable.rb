module Concerns
  class NotAuthorizedException < StandardError; end

  module TokenAuthenticatable
    extend ActiveSupport::Concern

    included do
      attr_reader :current_user

      before_action :authenticate_user

      rescue_from NotAuthorizedException, with: -> do |exception|
        render json: { error: exception.message }, status: 401
      end
    end

    private

    def authenticate_user
      result = DecodeAuthenticationCommand.call(request.headers)
      raise NotAuthorizedException.new(result.errors.first) if result.failure?
      @current_user = result.user
    end
  end
end
