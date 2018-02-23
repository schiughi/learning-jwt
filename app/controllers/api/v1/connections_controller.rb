class Api::V1::ConnectionsController < ApplicationController
  def create
    @social_profile = current_user.social_profiles.from_omniauth(auth)
    if @social_profile.valid?
      render json: { social_profile: @social_profile }
    else
      render json: { error: @social_profile.errors }, status: :unauthorized
    end
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
