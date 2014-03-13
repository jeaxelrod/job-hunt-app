# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group_names = ["interested", "applied", "interviews"]
categories = ["position", "company", "status", "job Posting", "documents", "notes"]
contents = [["Intern", "Amazon", "Applied", "http://www.amazon.com", "", ""],
								["Lab Assistant", "Oncomed Pharmaceuticals", "Interested", "", "", "Target Validation Group"],
								["Lab Technician", "Mohs Travel Tech and Services", "Intersted", "", "", "http://mohs.com"]]
User.create(name: "Jeremy Axelrod",
			 username: "jeaxelrod",
			 password: "foobar",
			 password_confirmation: "foobar",
			 admin: true,
			 categories: categories)
user = User.first
group_names.each do |name|
	user.groups.create(name: name)
end
contents.each_with_index do |job_content, n|
	job = user.jobs.create(position: job_content[0])
	Categorization.create(job_id: job.id, group_id: Group.find(n+1).id)
	job_content.each_with_index do |content, index|
		job.description.create(content: content, category: categories[index])
	end
end