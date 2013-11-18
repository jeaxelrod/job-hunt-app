require 'spec_helper'

describe "User Pages" do

  subject { page }
	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		
		it { should have_content(user.name) }
	#	it { should have_title(user.name) }
	end
	
	describe "signup page" do
		before { visit signup_path }
		
		let(:submit) { "Create my account" }
		
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		describe "with valid information" do
			before do
				fill_in "Username",			with: "Example User"
				fill_in "Password",     with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end
			
			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
			
			describe "with name" do
				before do 
					fill_in "Name", with: "Jeremy Axelrod" 
					click_button submit
				end
				it { should have_content('Jeremy Axelrod')}
			end
			
			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'uesr@example.com') }
				
				it { should have_link('Sign out') }
				it { should have_selector('div.alert-success', text: 'Welcome') }
			end
		end

		it { should have_content('Sign up') }
  end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do 
			sign_in user
			visit edit_user_path(user) 
		end
		
		describe "page" do
			it { should have_content("Update your profile") }
		end
		
		describe "with invalid information" do
			before { click_button "Save changes" }
			
			it { should have_content('error') }
		end
		
		describe "with valid information" do
			let(:new_name) { "New Name" }
			let(:new_username) { "newname" }
			before do
				fill_in "Username",				with: new_username
				fill_in "Password",				with: user.password
				fill_in "Confirmation",   with: user.password
				fill_in "Optional: Name", with: new_name
				click_button "Save changes"
			end
			
			it { should have_content(new_name) }
			it { should have_selector('div.alert-success') }
			it { should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.name).to eq new_name }
			specify { expect(user.reload.username).to eq new_username }
		end
	end
end
