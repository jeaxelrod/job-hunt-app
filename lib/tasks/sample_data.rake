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
		5.times do |n|
			column = "Column #{n}"
			job_columns[n] = user.job_columns.create!(title: column)
		end
		2.times do |n|
			name = "Jobs #{n}"
			job_group = user.job_groups.create!(name: name)
			5.times do |i|
				title = "job #{i}"
				job_group_id = job_group.id
				job = user.jobs.create!(title: title, job_group_id: job_group_id)
				5.times do |j|
					content = "Description #{j} for job #{i}"
					job.job_column_contents.create!(job_column_id: job_columns[j].id, content: content)
				end
			end
		end
	end
end