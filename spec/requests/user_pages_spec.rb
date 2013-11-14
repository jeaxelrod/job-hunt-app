require 'spec_helper'

describe "User Pages" do
  subject { page }
	
	describe "signup page" do
		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
  end
end
