# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do
      if duplicate_email?
        # flash[:notice] = 'You seem to already have an account, do you want to login instead?'
        redirect_to '/users/sign_up',
                    notice: 'You seem to already have an account, do you want to login instead?' and return
      end
      redirect_to '/users/sign_up', notice: 'Please fill out all fields' and return if empty_input?

      unless check_password_equals?
        redirect_to '/users/sign_up',
                    notice: 'Password and password confirmation do not match' and return
      end
    end
  end

  def duplicate_email?
    return false unless resource.errors.key?(:email)

    resource.errors.details[:email].any? do |hash|
      hash[:error] == :taken
    end
  end

  def empty_input?
    # returns false if there is email, password, password confirmation in the user input
    if params[:user][:email].empty? || params[:user][:password].empty? || params[:user][:password_confirmation].empty?
      return true
    end

    false
  end

  def check_password_equals?
    # check if password and password confirmation are the same
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def check_password_length?; end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name password lastname])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email name password lastname])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
