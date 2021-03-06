class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update, :destroy, :show]
	before_action :correct_user,   only: [:edit, :update]
 	before_action :non_signed_in_user, only: [:new, :create]

	def show
		@user = User.find(params[:id])
	end
	
  def new
		@user = User.new
    current_user = @user
  end
	
	def edit
	end
	
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			# Handle successful update
			flash[:success] = "Profile updated"
			redirect_to @user
		else
      flash[:failure] = "Some information is missing"
			render 'edit'
		end
	end
	
	def create
		@user = User.new(user_params)
    descriptions = ["position", "company", "status", "job posting", "documents", "notes"]
    @user.categories = descriptions
		if @user.save
			sign_in @user
			
			@user.groups.create(name: "Interested")
			@user.groups.create(name: "Applied")
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			flash[:failure] = "Error"
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
