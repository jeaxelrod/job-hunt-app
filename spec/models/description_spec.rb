require 'spec_helper'

describe JobDescription do

  let!(:user) { FactoryGirl.create(:user) }
	let!(:job_group) { FactoryGirl.create(:job_group, user_id: user.id) }
	let!(:job) { FactoryGirl.create(:job, user_id: user.id) }
	let!(:description) { FactoryGirl.create(:job_description, job_id: job.id) }
	
	subject { description }
	
	it { should be_valid }
	it { should respond_to(:content) } 
	it { should respond_to(:category) } 
	
	its(:job_id) { should eq(job.id) }
end