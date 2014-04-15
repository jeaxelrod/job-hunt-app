class JobsController < UsersController
	before_action :signed_in_user
	# valid link params[:job][:link] =~ /^#{URI::regexp}$/

	
	def index
		@groups = current_user.groups
		@selected_group = Group.find(params[:group_id]) if params[:group_id]
		if @selected_group
		  categorizations = current_user.categorizations.where(group_id: @selected_group.id)
			@jobs = Array.new
			categorizations.each do |categorization|
			  @jobs << Job.find(categorization.job_id)
			end
		else
		  @jobs = current_user.jobs
		end
		@columns = current_user.categories
		store_location
	end
	
	def edit
   ## begin
    @job = current_user.jobs.find(params[:id]) 
    @groups = @job.groups if @job.groups    
    @nongroups = @job.nongroups
    @nongroups.each do |group|
      @categorization = @job.categorizations.build
    end
    @descriptions = @job.descriptions

	end
	
	def update
		@job = current_user.jobs.find(params[:id])
		if @job.update_attributes(job_params)
			flash[:success] = "Job Updated"
			redirect_back_or 'index'
		else
			render 'edit'
		end
	end
	
	def new
    @job = current_user.jobs.build
		@group = current_user.groups.find(params[:group_id]) if params[:group_id]
    Group.all.length.times { @categorization = @job.categorizations.build }
    @descriptions = Array.new
    current_user.categories.each do |category|
      @descriptions << @job.descriptions.build
    end
	end
	
	def create 
    @job = current_user.jobs.build(job_params)
		#Adds http:// to non_blank links with a resonable domain name
		#if !link[/^(http:\/\/)/] && link != "" && link[/[A-Za-z0-9\.\-]+/]
			#link.insert(0, 'http://')
		#end
    if @job.save 
			flash[:success] = "Created new posting"
			redirect_to jobs_path
		else
      @descriptions = Array.new
      current_user.categories.each do |category|
        @descriptions << @job.descriptions.build
      end
			flash[:failure] = "Error"
			render 'new'
		end
	end
	
	def show
		@user = current_user
		@job = Job.find(params[:id])
		store_location
	end
  
  def destroy
    begin
      current_user.jobs.find(params[:id]).delete
      flash[:success] = "Job was deleted"
      redirect_to jobs_path
    rescue
      flash[:notice] = "Failed to destroy job"
      redirect_to jobs_path
    end
  end
	
	private

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to root_url, notice: "Please sign in." 
			end
		end
	
		def set_instance_job_group(group)
			@group = group
		end

    def job_params
			params.require(:job).permit(:id, :user_id, descriptions_attributes: [:id, :job_id, :category, :content],categorizations_attributes: [:id, :group_id, :job_id]) 
		end

    def job_content_params
			params.permit(job_column_contents_attributes: [ id: [ :content,:job_column_id]])
		end
		def non_signed_in_user 
		end
    
    def correct_user
    end
		
end