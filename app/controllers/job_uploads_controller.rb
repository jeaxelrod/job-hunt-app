class JobUploadsController < ApplicationController
  def new 
	  @job_upload = JobUpload.new
		@job = Job.find(params[:job_id])
		@job_upload = @job.job_uploads.build
	end
	
	def create
	  @job = Job.find(params[:job_id])
	  @job_upload = @job.job_uploads.build
	end
	
	def edit
	end
	
	def update
	end
	
	def destroy
	end

end
