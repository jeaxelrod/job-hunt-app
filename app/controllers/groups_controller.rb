class JobGroupsController < ApplicationController
  def index
	  @jobs = current_user.jobs
		@job_groups = current_user.job_groups
	end
	
	def show
	end
end
