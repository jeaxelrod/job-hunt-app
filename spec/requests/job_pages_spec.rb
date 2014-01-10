require 'spec_helper'

describe "Job pages" do
	
	subject { page }
	
	let(:user) { FactoryGirl.create(:user) }
	let(:job_group) { FactoryGirl.create(:job_group, user: user) }
	let!(:job) { FactoryGirl.create(:job, user: user, job_group: job_group) }
		
	describe "visiting job index without signing in" do
		before { visit user_jobs_path(user_id: user.id) }

		it { should have_content('Folio') }
	end
		
	describe "visiting job index" do
		before do
			sign_in user
			visit user_jobs_path( user_id: user.id)
		end
		
		it { should have_content('Jobs') }
		it { should have_content('Position') }
		it { should have_content('Company') }
		it { should have_content('Applied') }
		it { should have_content('Link') }
		it { should have_content('Notes') }
	
		describe "job groups" do
			it { should have_content(job_group.name) }
		end
	
		describe "job column contents" do
			it { should have_content(job.position) }
			it { should have_content(job.company) }
			it { should have_content(job.applied) }
			it { should have_content(job.description) }
			it { should have_content(job.notes) }
		end
	end
		
	describe "edit page" do
		let(:submit){ "Save changes" }
		before do
			sign_in user
			click_link "Jobs"
			click_link "Edit"
		end
		
		describe "it should back to page it was accessed from" do
			before { click_button submit}
			
			it { should have_content("Position") }
		end
		
		describe "when accessed from job profile" do
			before do 
				visit user_job_path(user_id: user.id, id: job.id) 
				click_link "Edit"
			end
			describe "should bring back to job profile page" do
				before { click_button submit }
				it { should_not have_content("Position") }
			end
		end
			
	end
		
	describe "creating new job" do
	end
end