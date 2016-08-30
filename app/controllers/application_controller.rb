class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?

  def auth_user
    if !user_signed_in?
      redirect_to signup_path
    end
  end

  def configure_devise_permitted_parameters
    permitted_params_signup = [:full_name, :email, :password, :password_confirmation, :avatar, :location, :organization]
    permitted_params_update = [:full_name, :email, :password, :password_confirmation,:current_password, :avatar, :location, :organization, :bio]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update, keys: permitted_params_update) 
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up, keys: permitted_params_signup)
    end
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

end
