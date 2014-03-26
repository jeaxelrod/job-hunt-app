FactoryGirl.define do
	factory :user do
		name  "Person"
		username "person"
		password "foobar"
		password_confirmation "foobar"
		
		factory :admin do
			admin true
		end
	end
	factory :job do
		position "Position"
		company "Orange"
		location "Mountain View, CA"
		applied "False"
		user
	end
	factory :group do
		name "Internships"
		user
	end
	factory :description do
	  category "Category"
		content "Content"
		job
	end
end