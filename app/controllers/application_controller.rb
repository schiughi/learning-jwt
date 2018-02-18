class ApplicationController < ActionController::API
  include Concerns::TokenAuthenticatable
end
