require 'spec_helper'

describe User do
  before { @user = User.new(username: "Example User", password: "foobar",
														password_confirmation: "foobar") }
	
	subject { @user }
	
	it { should respond_to(:username) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	
	it { should be_valid }
	
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
end
