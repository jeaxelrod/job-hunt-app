require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
		it "should have title 'The Croc Hunter'" do
			visit root_path
			expect(page).to have_selector('h1', text:'The Croc Hunter')
		end
  end
	
	describe "Contact page" do
		it "should have my contact info" do
			visit contact_path
			expect(page).to have_content('Contact')
		end
	end
end
