require 'spec_helper'

describe "Job pages" do
	
	subject { page }
	
	let(:user) { FactoryGirl.create(:user) }
	let(:job_group) { FactoryGirl.create(:job_group, user: user) }
	let(:job1) { FactoryGirl.create(:job, user: user, job_group: job_group) }
	let(:job2) { FactoryGirl.create(:job, user: user, job_group: job_group) }
	let(:column1) { FactoryGirl.create(:job_column, user: user) }
	let(:column2) { FactoryGirl.create(:job_column, user: user) }
	let!(:job1_content1) { FactoryGirl.create(:job_column_content, 
																job_column: column1, job: job1) }
	let!(:job1_content2) { FactoryGirl.create(:job_column_content, 
																job_column: column2, job: job1) }
	let!(:job2_content1) { FactoryGirl.create(:job_column_content, 
																job_column: column1, job: job2) }
	let!(:job2_content2) { FactoryGirl.create(:job_column_content, 
																job_column: column2, job: job2) }
		
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
		
		describe "jobs" do
			it { should have_content(job1.title) }
			it { should have_content(job2.title) }
		end
			
		describe "job columns" do
			it { should have_content(column1.title) }
			it { should have_content(column2.title) }
		end
			
		describe "job column contents" do
			it { should have_content(job1_content1.content) }
			it { should have_content(job1_content2.content) }
			it { should have_content(job2_content1.content) }
			it { should have_content(job2_content2.content) }
		end
	end
		
	describe "edit page" do
	
		before do
			sign_in user
			visit edit_user_job_path(user_id: user.id, id: job1.id)
		end
			
		describe "page" do
			it { should have_content("Edit Jobs") }
			it { should_not have_content('Content') }
		end
			
		describe "with updated information" do
			before do
				fill_in column1.title, with: "Meow"
				fill_in column2.title, with: "Cat"
				click_button "Save changes" 
			end
				
			it { should have_content("Meow") }
			it { should have_content("Cat") }
		end
	end
		
	describe "creating new job" do
		
		before do	
			sign_in user
			visit user_jobs_path( user_id: user.id)
			click_link "New"
		end
			
		describe "page" do
			it { should have_content("Create new Job Listing") }
		end
			
		describe "with correct information" do
			before do
				fill_in column1.title, with: "Meow"
				fill_in column2.title, with: "Cat"
				click_button "Create Posting"
			end
				
			it { should have_content("Meow") }
			it { should have_content("Cat") }
		end
	end
end