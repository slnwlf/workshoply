class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?
  before_filter :set_return_path 

  def set_return_path
    unless devise_controller? || request.xhr? || !request.get?
      session["user_return_to"] = request.url
    end
  end

  def auth_user
    if !user_signed_in?
      redirect_to signup_path
    end
  end

  def configure_devise_permitted_parameters
    permitted_params_signup = [:full_name, :email, :password, :password_confirmation, :avatar, :location, :organization]
    permitted_params_update = [:full_name, :email, :password, :password_confirmation,:current_password, :avatar, :location, :organization, :bio, :link_to_bio]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update, keys: permitted_params_update) 
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up, keys: permitted_params_signup)
    end
  end

  def after_sign_in_path_for(resource)
    session["user_return_to"] || user_path(current_user)
  end

  #mailboxer
  helper_method :mailbox, :conversation

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  protected
  # http://stackoverflow.com/questions/16364626/rails-3-2-13-devise-2-2-3-method-authenticate-scope-throws-error-wrong-nu#answer-16364926
  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      redirect_to login_path, :notice => 'Sign in to continue.'
    end
  end

end
