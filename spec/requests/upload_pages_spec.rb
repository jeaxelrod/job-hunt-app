require 'spec_helper'

describe "Upload functionality" do
	let(:user) { FactoryGirl.create(:user) }
	let(:job_group) { FactoryGirl.create(:job_group, user: user) }
	let!(:job) { FactoryGirl.create(:job, user: user, job_group: job_group) }
	
	subject { page }
	
	describe "when visiting where upload files" do
	  before do
		  sign_in user
			visit user_jobs_path(user_id: user.id)
			click_link 'Upload'
		end
		
		it { should have_content('Upload') }
	
	  describe "and then uploading a file with the wrong format" do
	    before do
			  attach_file 'job_upload_upload', Rails.root.join('spec/fixtures/files/test.txt')
				click_button 'Upload'
			end
			it "should not upload" do
        expect(JobUpload.all.size).to eq(0) 
			end
		end
		
		describe "and then uploading a file" do
		  before do
			  attach_file 'job_upload_upload', Rails.root.join('spec/fixtures/files/test.doc')
				click_button 'Upload'
			end
			it "should upload" do
			  expect(JobUpload.all.size).to eq(1) 
			end
		end
	end
end
		