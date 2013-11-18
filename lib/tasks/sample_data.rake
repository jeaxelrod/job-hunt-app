namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Jeremy Axelrod",
								 username: "jeaxelrod",
								 password: "foobar",
								 password_confirmation: "foobar",
								 admin: true)
		
	end
end