require 'spec_helper'

describe JobUpload do
  let!(:user) { FactoryGirl.create(:user) }
	let!(:job_group) { FactoryGirl.create(:job_group) }
	let!(:job) { FactoryGirl.create(:job) }
	let!(:job_upload) { FactoryGirl.create(:job_upload, job_id: job.id) }
	
	subject{ job_upload } 
	
	it { should respond_to(:job_id) }
	it { should respond_to(:upload_file_name) }
	it { should respond_to(:upload_content_type) }
	it { should respond_to(:upload_file_size) }
	it { should respond_to(:upload_updated_at) }
	
	it { should be_valid } 
	
end
