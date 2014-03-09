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
		
	end
end
		