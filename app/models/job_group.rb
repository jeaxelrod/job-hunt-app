class JobGroup < ActiveRecord::Base
	belongs_to  :user
	has_many :jobs
end

# ==Schema Information
#
# Table name: job_group
#
# id          :integer    not null, primary key
# name        :string     not null
# user_id     :integer    not null
# created_at  :datetime   not null
# updated_at  :datetime   not null
#