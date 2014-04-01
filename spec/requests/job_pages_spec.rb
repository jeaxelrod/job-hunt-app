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
			visit jobs_path
			click_link "Edit"
		end
		
		describe "it should bring back to page it was accessed from" do
			before { click_button submit}
			
			it { should have_link(group.name.titleize) }
			it { should have_link("All") }
			it { should have_content(description.content) }
			it { should have_content(description.category.titleize) }	
		end
		
		describe "should save changes" do
		  before do
			  fill_in description.category.titleize, with: "Position"
			  click_button submit
			end
			
			it { should have_content "Position" }
		end
##		describe "when accessed from job profile" do
#			before do 
#				visit user_job_path(user_id: user.id, id: job.id) 
#				click_link "Edit"
#			end
#			describe "should bring back to job profile page" do
#				before { click_button submit }
#				it { should_not have_content("Position") }
#			end
##		end
			
	end
		
	describe "creating new job" do
		before do
		  sign_in user
			visit jobs_path
			click_link "New"
			user.categories.each do |field|
			  fill_in field.titleize, with: "Position #{field}"
			end
			click_button "Create Posting"
		end
		
	  it { should have_content "Position category" }
		
	end
  
  describe "creating a new job with a job group" do
    before do
      sign_in user
      visit group_jobs_path(group_id: group.id)
      click_link "New"
      user.categories.each do |field|
        fill_in field.titleize, with: "Position #{field}"
      end
      click_button "Create Posting"
      click_link "All"
      click_link group.name.titleize
    end
    
    it { should have_content "Position category" }
  end 
  
  describe "creating a new job with two job groups" do
    before do
      sign_in user
      group2 = user.groups.create(name: "Group 2")
      visit jobs_path
      click_link "New"
      check "job_categorizations_attributes_0_group_id"
      check "job_categorizations_attributes_1_group_id"
      user.categories.each do |field|
        fill_in field.titleize, with: "Position #{field}"
      end
      click_button "Create Posting"
    end
    it "belong in group 1" do
      click_link group.name
      expect(page).to have_content("Position category")
    end
    it "belong in group 2" do
     click_link "Group 2"
     expect(page).to have_content("Position category")
    end
  end
end