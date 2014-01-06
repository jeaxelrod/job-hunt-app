require 'spec_helper'

describe "Job pages" do
	
	subject { page }
	
	let(:user) { FactoryGirl.create(:user) }
	let(:job_group) { FactoryGirl.create(:job_group, user: user) }
	let(:job) { FactoryGirl.create(:job, user: user, job_group: job_group) }
		
	describe "visiting job index without signing in" do
		before { visit user_jobs_path(user_id: user.id) }

		it { should have_content('The Croc Hunter') }
	end
		
	describe "visiting job index" do
		before do
			sign_in user
			visit user_jobs_path( user_id: user.id)
		end
			
		it { should have_content('Jobs') }
			
		describe "job groups" do
			it { should have_content(job_group.name) }
		end
		
		
		it { should have_content("Position") }
		it { should have_content("Company") }
		it { should have_content("Applied?") }
		it { should have_content("Link") }
		it { should have_content("Notes") }
	
			
		describe "job column contents" do
			it { should have_content(job.position) }
			it { should have_content(job.company) }
			it { should have_content(job.applied) }
			it { should have_content(job.description) }
			it { should have_content(job.notes) }
		end
	end
		
	describe "edit page" do
	
		before do
			sign_in user
			visit edit_user_job_path(user_id: user.id, id: job.id)
		end
			
	end
		
	describe "creating new job" do
	end
end