class JobsController < UsersController
	before_action :signed_in_user, only: [:index]
	before_action :correct_user, only: [:index]
	
	def index
		@user = User.find(params[:id])
		@jobs = @user.jobs
		@job_groups = @user.job_groups
		@job_columns = @user.job_columns
	end
end