class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :destroy, :show]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy
	before_action :non_signed_in_user, only: [:new, :create]

	def show
		@user = User.find(params[:id])
	end
	
  def new
		@user = User.new
  end
	
	def edit
	end
	
	def jobs
		@user = User.find(params[:id])
		render jobs_path
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			# Handle successful update
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to root_path
	end
	
	private
		
		def user_params
			params.require(:user).permit(:username, :password, :password_confirmation, :name)
		end
		
		#Before filters
			
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to root_url, notice: "Please sign in." 
			end
		end
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
		
		def non_signed_in_user
			if signed_in?
				redirect_to root_url, notice: "Already signed in. Can't create new account"
			end
		end
end
