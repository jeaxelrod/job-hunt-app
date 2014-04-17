class GroupsController < ApplicationController
	before_action :signed_in_user
  
  def index
	  @jobs = current_user.jobs
		@groups = current_user.groups
	end
	
	def show
	end
  
  def edit
    @groups = current_user.groups 
  end
  
  def update
    @groups = Array.new
    @updated = Hash.new
    params['groups'].keys.each do |id|
      @group = Group.find(id)
      @groups << @group
      unless @group.update_attributes(edit_group_params(id))
        @errors = true
      end
    end
    unless @errors
      redirect_to "/jobs"
    else
      render :action => 'edit'
    end
  end
  
  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:success] = "Created new job group"
      redirect_to jobs_path
    else
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
      render "new"
    end
  end
  
  private
  
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
    
    def edit_group_params(id)
      params.require(:groups).fetch(id).permit(:name)
    end
    
    private

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to root_url, notice: "Please sign in." 
			end
		end
end
