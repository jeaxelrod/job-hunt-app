require 'spec_helper'

describe Description do

  let!(:user) { FactoryGirl.create(:user) }
	let!(:group) { FactoryGirl.create(:group, user: user) }
	let!(:job) { FactoryGirl.create(:job, user: user) }
	let!(:description) { FactoryGirl.create(:description, job: job) }
	
	subject { description }
	
	it { should be_valid }
	it { should respond_to(:content) } 
	it { should respond_to(:category) } 
	
	its(:job_id) { should eq(job.id) }
end