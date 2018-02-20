class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user, only: %i(create callback)

  def create
    result = AuthenticatePasswordCommand.call(username: params[:username],
                                              password: params[:password])
    if result.success?
      render json: { token: result.token }
    else
      render json: { error: result.errors }, status: :unauthorized
    end
  end

  def index
    render json: { auth: "hello #{current_user.username}. you are authorized." }
  end

  def callback
    result = AuthenticateProviderCommand.call(request.env["omniauth.auth"])
    if result.success?
      render json: { token: result.token }
    else
      render json: { error: result.errors }, status: :unauthorized
    end
  end
end
