require 'spec_helper'

describe User do
  before { @user = User.new(username: "Example User", password: "foobar",
														password_confirmation: "foobar", name: "Example") }
	
	subject { @user }
	
	it { should respond_to(:username) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:name) }
	it { should respond_to(:admin) }
	it { should respond_to(:jobs) }
	it { should respond_to(:job_groups) }
	
	it { should be_valid }
	it { should_not be_admin }
	
	describe "with admin attribute set to 'true'" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end
		
		it { should be_admin }
	end
	
	describe "when username is not present" do
		before { @user.username = " " }
		it { should_not be_valid }
	end
	
	describe "when username is too long" do
		before { @user.username = "a" * 51 }
		it { should_not be_valid }
	end
	
	describe "when username is already taken" do
		before do
			user_with_same_username = @user.dup
			user_with_same_username.username = @user.username.upcase
			user_with_same_username.save
		end
		it { should_not be_valid }
	end
	
	describe "when password is blank" do
		before do
			@user = User.new(username: "Example User", password: " ", 
											 password_confirmation: " " )
		end
		it { should_not be_valid }
	end
	
	describe "when passwords mismatch" do
		before do
			@user = User.new(username: "Example User", password: "foobar",
											 password_confirmation: "mismatch")
		end
		it { should_not be_valid }
	end
	
	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5}
		it { should be_invalid }
	end
	
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(username: @user.username) }
		
		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end
		
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			
			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end
	
	describe "remember token" do
		before { @user.save }
		its (:remember_token) { should_not be_blank }
	end
	
	describe "job associations" do
		
		before { @user.save }
		let(:job_group) { FactoryGirl.create(:job_group, user: @user) }
		let!(:older_job) do
			FactoryGirl.create(:job, user: @user, job_group: job_group, 
												 created_at: 1.day.ago)
		end
		let!(:newer_job) do
			FactoryGirl.create(:job, user: @user, job_group: job_group, 
												 created_at: 1.hour.ago)
		end
		
		
		it "should have the right jobs in the right order" do
			expect(@user.jobs.to_a).to eq [newer_job, older_job]
		end
		
		it "deleting user should destroy jobs" do
			jobs = @user.jobs.to_a
			@user.destroy
			expect(jobs).not_to be_empty
			jobs.each do |job|
				expect(Job.where(id: job.id)).to be_empty
			end
		end
	end
	
end
