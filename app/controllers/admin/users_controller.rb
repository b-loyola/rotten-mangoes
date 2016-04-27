class Admin::UsersController < ApplicationController

	before_filter :restrict_admin_access

	def index
		@users = User.all.page(params[:page]).per(5)
	end

	def edit
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
  	@user.destroy
  	UserMailer.account_deleted(@user).deliver_now
  	redirect_to admin_users_path
	end

end
