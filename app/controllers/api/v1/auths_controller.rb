class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    result = AuthenticateCommand.call(authentication_params)
    if result.success?
      render json: { token: result.token }
    else
      render json: { error: result.errors }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.permit(:username, :password)
  end
end
