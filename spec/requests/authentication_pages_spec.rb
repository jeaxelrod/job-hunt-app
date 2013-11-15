require 'spec_helper'

describe "Authentication" do
	
	subject { page }
	
	describe "signin page" do
		before {  visit root_path }
		
		let(:submit) { "Sign in" }
		
		it { should have_content('The Croc Hunter') }
		
		describe "with valid signin info" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Username", with: user.username
				fill_in "Password", with: user.password
				click_button submit
			end
			it { should have_content("Jeremy Axelrod") }
			it { should have_link('Profile',     href: user_path(user)) }
			it { should have_link('Sign out',    href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }
			
			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_button('Sign in') }
			end	
		end
		
		
		describe "with invalid signin info" do
			before { click_button submit }
			
			it { should have_content("Invalid") }
			
			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_content("Invalid") }
			end
		end
	end
end