require 'spec_helper'

describe "Job pages" do
	
	subject { page }
	
	describe "index page" do
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
		
		before { sign_in user, no_capybara true }
		
		describe "visiting job index" do
			before { visit jobs_path }
			
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
	end
end