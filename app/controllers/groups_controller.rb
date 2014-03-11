class GroupsController < ApplicationController
  def index
	  @jobs = current_user.jobs
		@groups = current_user.groups
	end
	
	def show
	end
end
