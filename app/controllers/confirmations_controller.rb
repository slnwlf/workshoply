class ConfirmationsController < Devise::ConfirmationsController
  protected
	# overide these methods
	# change new_session_path to login_path
	def after_resending_confirmation_instructions_path_for(resource_name)
    is_navigational_format? ? login_path : '/'
  end

  def after_confirmation_path_for(resource_name, resource)
  	# sign user in
    sign_in(resource)
    # send use to after sign in path
    after_sign_in_path_for(resource)
  end
end