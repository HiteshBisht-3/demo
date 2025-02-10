# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [ :create ]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = User.find_for_database_authentication(login: params[:user][:login])

    if resource&.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      render json: { message: "Signed in successfully" }, status: :ok
    else
      render json: { error: "Invalid login credentials" }, status: :unauthorized
    end
  end

  # DELETE /resource/sign_out
  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully."
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :attribute ])
  end
end
