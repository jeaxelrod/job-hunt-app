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
		job_group
	end
	factory :job_column do
		sequence(:title) { |n| "Job Title #{n}" }
		user
	end
	factory :job_column_content do
		content "Intern"
		job_column
		job
	end
	factory :job_group do
		name "Internships"
		user
	end
end