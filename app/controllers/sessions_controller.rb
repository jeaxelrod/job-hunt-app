class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by(username: params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid username/password combination'
			render 'static_pages/index' #with error message
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end
end
