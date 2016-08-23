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
    permitted_params_signup = [:email, :password, :password_confirmation]
    permitted_params_update = [:email, :password, :password_confirmation,:current_password]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update, keys: permitted_params_update) 
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up, keys: permitted_params_signup)
    end
  end
end
