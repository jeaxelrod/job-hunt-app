require 'spec_helper'

describe Job do
  let!(:user) { FactoryGirl.create(:user) }
	let!(:job_group) { FactoryGirl.create(:job_group, user_id: user.id) }
	let!(:job) { FactoryGirl.create(:job, user_id: user.id) }

	
	
	
	subject{ job }
	
	it { should respond_to(:user_id) }

	its(:user) { should eq user }
	
	it { should be_valid }
	
	describe "when user_id is not present" do
		before { job.user_id = nil }
		it { should_not be_valid }
	end
	
end
