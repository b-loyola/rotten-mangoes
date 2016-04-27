class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def account_deleted(user)
		@user = user
		@url  = 'http://example.com/login'
		mail(to: @user.email, subject: "Your account has been deleted")
	end

end
