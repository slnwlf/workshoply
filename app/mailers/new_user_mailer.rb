class NewUserMailer < ApplicationMailer

	def new_user_message(user)
		@user = user
		mail( to: 'dave.sloan@gmail.com', subject: 'A new user has created an account!')
	end
end
