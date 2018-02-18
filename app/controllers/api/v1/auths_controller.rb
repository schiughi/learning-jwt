class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user, only: %i(create)

  def create
    result = AuthenticateCommand.call(username: authentication_params[:username],
                                      password: authentication_params[:password])
    if result.success?
      render json: { token: result.token }
    else
      render json: { error: result.errors }, status: :unauthorized
    end
  end

  def index
    render json: { auth: "you are authorized" }
  end

  private

  def authentication_params
    params.permit(:username, :password)
  end
end
