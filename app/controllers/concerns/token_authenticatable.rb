module Concerns
  class NotAuthorizedException < StandardError; end

  module TokenAuthenticatable
    extend ActiveSupport::Concern
    include ActionController::HttpAuthentication::Token::ControllerMethods

    included do
      attr_reader :current_user

      before_action :authenticate_user

      rescue_from NotAuthorizedException, with: :render_unauthorized
    end

    protected

    def render_unauthorized(exception)
      render json: { error: exception.message }, status: 401
    end

    private

    def authenticate_user
      if authenticate_token?
        @current_user = @result.user
      else
        raise NotAuthorizedException.new("token missing") unless @result
        raise NotAuthorizedException.new(@result.error_message)
      end
    end

    def authenticate_token?
      authenticate_with_http_token do |token, options|
        @result = DecodeAuthenticationCommand.call(token)
        @result.success?
      end
    end
  end
end
