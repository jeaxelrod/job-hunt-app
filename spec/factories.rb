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
		title "Jobs"
		user
	end
	factory :job_column do
		title "Job Title"
		content "Intern"
		job
	end
end