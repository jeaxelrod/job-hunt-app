require 'spec_helper'

describe Categorization do
  let!(:user) { FactoryGirl.create(:user) }
	let!(:group) { FactoryGirl.create(:group, user: user) }
	let!(:job) { FactoryGirl.create(:job, user: user) }
	let!(:category) { Categorization.create(job: job, group: group) }
	
	subject { category }
	
	its(:job_id) { should eq(job.id) }
	its(:group_id) { should eq(group.id) }
	
	it { should be_valid }

	
end
