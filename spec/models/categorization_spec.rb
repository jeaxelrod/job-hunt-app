require 'spec_helper'

describe Categorization do
  let!(:user) { FactoryGirl.create(:user) }
	let!(:job_group) { FactoryGirl.create(:job_group, user_id: user.id) }
	let!(:job) { FactoryGirl.create(:job, user_id: user.id) }
	let!(:category) { Categorization.create(job_id: job.id, job_group_id: job_group.id) }
	
	subject { category }
	
	its(:job_id) { should eq(job.id) }
	its(:job_group_id) { should eq(job_group.id) }
	
	it { should be_valid }

	
end
