class JobsController < UsersController
	#before_action :signed_in_user, only: [:index]
	before_action :correct_user, only: [:index]
	# valid link params[:job][:link] =~ /^#{URI::regexp}$/

	
	def index
		@user = User.find(params[:user_id])
		@jobs = @user.jobs
		@job_groups = @user.job_groups
		@job_columns = ["position", "company", "applied", "description", "link", "notes" ]
		@last_column = @job_columns.last
		store_location
	end
	
	def edit
		@user = User.find(params[:user_id])
		@job = Job.find(params[:id])
	end
	
	def update
		@user = User.find(params[:user_id])
		@job = Job.find(params[:id])
		link = params[:job][:link]
		#Adds http:// to non_blank links with a resonable domain name
		if !link[/^(http:\/\/)/] && link != "" && link[/[A-Za-z0-9\.\-]+/] 
			link.insert(0, 'http://')
		end
		if @job.update_attributes(job_params)
			flash[:success] = "Job Updated"
			redirect_back_or 'index'
		else
			render 'edit'
		end
	end
	
	def new
		@user = User.find(params[:user_id])
		@job_group = @user.job_groups.find(params[:job_group_id])
		set_instance_job_group(@job_group)
		@job = @user.jobs.build(job_group_id: @job_group.id)
	end
	
	def create 
		@user = User.find(params[:user_id])
		@job = @user.jobs.build(job_params)
		link = params[:job][:link]
		#Adds http:// to non_blank links with a resonable domain name
		if !link[/^(http:\/\/)/] && link != "" && link[/[A-Za-z0-9\.\-]+/]
			link.insert(0, 'http://')
		end
		if @job.save
			flash[:success] = "Created new Posting"
			redirect_to user_jobs_path
		else
			flash[:failure] = "Error"
			render 'new'
		end
	end
	
	def show
		@user = User.find(params[:user_id])
		@job = Job.find(params[:id])
		store_location
	end
	
	private
	
		def set_instance_job_group(group)
			@job_group = group
		end

		def job_params
			params.require(:job).permit(:id, :user_id, :job_group_id, :position, :company, :location, :applied, :notes, :description, :link ) 
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