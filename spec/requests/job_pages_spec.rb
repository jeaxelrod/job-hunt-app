require 'spec_helper'

describe "Job pages" do
	
	subject { page }
	
	let!(:user) { FactoryGirl.create(:user, categories: ['category']) }
	let!(:group) { FactoryGirl.create(:group, user: user) }
	let!(:job) { FactoryGirl.create(:job, user: user) }
	let!(:description) { FactoryGirl.create(:description, job: job, content: "content", category: "category") }
	let!(:category) { Categorization.create(job: job, group: group) }
		
	describe "visiting job index without signing in" do
		before { visit jobs_path }

		it { should have_content('Folio') }
	end
		
	describe "visiting job index" do
		before do
			sign_in user
			visit jobs_path
		end
		
		it { should have_link(group.name.titleize) }
		it { should have_link("All") }
		it { should have_content(description.content) }
		it { should have_content(description.category.titleize) } 
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
		describe "links" do
			before do
				sign_in user
				visit new_user_job_path(user_id: user.id, job_group_id: job_group.id)
				fill_in "Link", with: "www.google.com"
				click_button "Create Posting"
			end
			
			it { should have_link('google.com', href='http://www.google.com') }
		end
	
		describe "link with http in it" do
			before do
				sign_in user
				visit new_user_job_path(user_id: user.id, job_group_id: job_group.id)
				fill_in "Link", with: "http://www.google.com"
				click_button "Create Posting" 
			end
			
				it { should have_link('google.com', href='http://www.google.com') }
		end
	end
end