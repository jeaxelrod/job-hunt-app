namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Jeremy Axelrod",
								 username: "jeaxelrod",
								 password: "foobar",
								 password_confirmation: "foobar",
								 admin: true)
		user = User.first
		job_columns = []
		names = ["Interested", "Applied"]
		column_titles = ["Position", "Company", "Applied?", "Date Added"]
		job_contents = [["Intern", "Amazon", "Yes", "11/20/13"],
										["Lab Assistant", "Oncomed Pharmaceuticals", "No" , "11/20/13"],
										["Janitor", "UC Berkeley", "No", "11/23/12"],
										["Web Designer", "Designers", "Yes", "11/20/13"],
										["Lab Technician", "Mohs Travel Tech and Services", "Yes", "10/15/13"]]
		5.times do |n|
			job_columns[n] = user.job_columns.create!(title: column_titles[n])
		end
		2.times do |n|
			job_group = user.job_groups.create!(name: names[n])
			5.times do |i|
				title = "job #{i}"
				job_group_id = job_group.id
				job = user.jobs.create!(title: title, job_group_id: job_group_id)
				4.times do |j|
					job.job_column_contents.create!(job_column_id: job_columns[j].id, content: job_contents[i][j] )
				end
			end
		end
	end
end