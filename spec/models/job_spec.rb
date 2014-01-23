require 'spec_helper'

describe Job do
  let(:user) { FactoryGirl.create(:user) }
	let(:job_group) { FactoryGirl.create(:job_group) }
	before { @job = user.jobs.build(job_group_id: job_group.id) }
	
	subject{ @job }
	
	it { should respond_to(:user_id) }
	it { should respond_to(:job_group_id) }
	its(:user) { should eq user }
	its(:job_group_id) { should eq job_group.id }
	its(:job_group_id) { should_not eq nil }
	
	it { should be_valid }
	
	describe "when user_id is not present" do
		before { @job.user_id = nil }
		it { should_not be_valid }
	end
	
end
