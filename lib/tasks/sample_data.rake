namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Jeremy Axelrod",
								 username: "jeaxelrod",
								 password: "foobar",
								 password_confirmation: "foobar",
								 admin: true)
		user = User.first
		names = ["Interested", "Applied"]
		column_titles = ["Position", "Company", "Applied?", "Date Added"]
		job_contents = [["Intern", "Amazon", "Seattle, WA", true, "Entry level", "", "amazon.com"],
										["Lab Assistant", "Oncomed Pharmaceuticals", "Redwood City, CA" , false, "Mom works here", "Target Validation Group" , "oncomed.com"],
										["Janitor", "UC Berkeley", "Berkeley, CA", true, "Dr. Steinman's lab under stevie", "", "berkeley.edu"],
										["Web Designer", "Designers", "San Francisco, CA", false, "Self-employed", "",""],
										["Lab Technician", "Mohs Travel Tech and Services", "Vacaville, CA", true, "Talked to david", "", "mohs.com"]]
		
		2.times do |n|
			job_group = user.job_groups.create!(name: names[n])
			5.times do |i|
				position = job_contents[i][0]
				company =  job_contents[i][1]
				location = job_contents[i][2]
				applied = job_contents[i][3]
				notes = job_contents[i][4]
				description = job_contents[i][5]
				link = job_contents[i][6]
				job_group_id = job_group.id
				job = user.jobs.create!(position: position, 
																company: company,
																job_group_id: job_group_id,
																location: location,
																applied: applied,
																notes: notes,
																description: description,
																link: link)
			end
		end
	end
end