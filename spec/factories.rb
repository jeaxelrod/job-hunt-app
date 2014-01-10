FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:username) { |n| "person-#{n}" }
		password "foobar"
		password_confirmation "foobar"
		
		factory :admin do
			admin true
		end
	end
	factory :job do
		position "Jobs"
		company "Orange"
		location "Mountain View, CA"
		applied "False"
		user
		job_group
	end
	factory :job_group do
		name "Internships"
		user
	end
end