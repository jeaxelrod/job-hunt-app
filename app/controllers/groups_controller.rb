class GroupsController < ApplicationController
  def index
	  @jobs = current_user.jobs
		@groups = current_user.groups
	end
	
	def show
	end
  
  def new

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
end
