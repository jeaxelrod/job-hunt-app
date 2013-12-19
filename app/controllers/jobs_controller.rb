class JobsController < UsersController
	#before_action :signed_in_user, only: [:index]
	before_action :correct_user, only: [:index]

	
	def index
		@user = User.find(params[:user_id])
		@jobs = @user.jobs
		@job_groups = @user.job_groups
		@job_columns = @user.job_columns
	end
	
	def edit
		@user = User.find(params[:user_id])
		@job = Job.find(params[:id])
		@job_columns = @user.job_columns
	end
	
	def update
		@user = User.find(params[:user_id])
		@job = Job.find(params[:id])
		@contents = @job.job_column_contents
		@job_columns = @user.job_columns
		if @job.update_attributes(job_params)
			flash[:success] = "Job Updated"
			redirect_to user_jobs_path
		else
			render 'edit'
		end
	end
	
	def new
		@user = User.find(params[:user_id])
		@job_columns = @user.job_columns
		@job_group = @user.job_groups.find(params[:job_group_id])
		set_instance_job_group(@job_group)
		@job = @user.jobs.build(job_group_id: @job_group.id)
		@job_columns.each do |column|
			@job.job_column_contents.build(job_column_id: column.id)
		end
	end
	
	def create 
		@user = User.find(params[:user_id])
		@job_columns = @user.job_columns
		@job = @user.jobs.build(job_group_id: params[:job][:job_group_id])
		i = 0
		@job_columns.each do |column|
			@job.job_column_contents.build(content: params[:job][:job_column_contents_attributes][:"#{i}"][:content], job_column_id: column.id)
			i += 1
		end
		if @job.save
			flash[:success] = "Created new Posting"
			redirect_to user_jobs_path
		else
			render 'new'
		end
	end

	
	private
	
		def set_instance_job_group(group)
			@job_group = group
		end
		def job_group 
			@job_group
		end
		def job_params
			params.require(:job).permit(:id, :user_id, :job_group_id, :title, job_column_contents_attributes: [:id, :content, :job_id, :job_column_id]) 
		end
		def job_content_params
			params.permit(job_column_contents_attributes: [ id: [ :content,:job_column_id]])
		end
		def correct_user
			@user = User.find(params[:user_id])
			redirect_to(root_url) unless current_user?(@user)
		end
		def non_signed_in_user 
		end
end