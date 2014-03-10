class JobUploadsController < ApplicationController
  def new 
	  @job_upload = JobUpload.new
		@job = Job.find(params[:job_id])
		@job_upload = @job.job_uploads.build
	end
	
	def create
	  @job = Job.find(params[:job_id])
	  @job_upload = @job.job_uploads.build
		upload = params[:job_upload][:upload]
		@job_upload.upload_file_name = upload.original_filename
		@job_upload.upload_content_type = @job_upload.upload_file_name[/\.(\w+)/, 1]
		@job_upload.url = "./public/uploads/#{@job_upload.upload_file_name}"
		@job_upload.upload_updated_at = DateTime.now
		@job_upload.upload_file_size = upload.size
		if @job_upload.save
		  File.open(@job_upload.url, 'wb') { |f| f.write(upload.read) }
		  flash[:notice] = "File uploaded"
		else
		  flash[:warning] = "File didn't upload"
		end 	
		render 'new'
	end
	
	def edit
	end
	
	def update
	end
	
	def destroy
	end

end
