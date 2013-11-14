require 'spec_helper'

describe "StaticPages" do
	subject { page }
	
  describe "Home page" do
		before { visit root_path }
		it { should have_selector('h1', text:'The Croc Hunter') }

		
  end
	
	describe "Contact page" do
		it "should have my contact info" do
			visit contact_path
			expect(page).to have_content('Contact')
		end
	end
end
