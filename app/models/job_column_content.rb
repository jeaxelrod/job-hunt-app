class JobColumnContent < ActiveRecord::Base
	belongs_to :job
	belongs_to :job_column
	#validates :job_id, presence: true HELP: Can't create job posting with this listed
	validates :job_column_id, presence: true
end

# ==Schema Information
#
# Table name: job_column_content
# id             :integer     not null, primary key
# content        :string      
# job_id         :integer     not null
# job_column_id  :integer     not null
# created_at     :datetime    not null
# updated_at     :datetime    not null
#
