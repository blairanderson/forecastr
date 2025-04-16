class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :create ]

  def create
    user = User.new(user_params)

    if user.save
      render json: {
        status: :success,
        message: "User created successfully",
        api_key: user.api_key
      }, status: :created
    else
      render json: {
        status: :error,
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
