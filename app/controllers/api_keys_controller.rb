class ApiKeysController < ApplicationController
  before_action :require_authentication

  def show
    render json: { api_key: current_user.api_key }
  end

  def update
    current_user.regenerate_api_key!
    render json: { api_key: current_user.api_key }
  end
end
