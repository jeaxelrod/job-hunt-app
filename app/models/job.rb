class Job < ActiveRecord::Base
	belongs_to :user
	belongs_to :job_columns
	validates :user_id, presence: true
	accepts_nested_attributes_for :job_columns
end


# == Schema Information
#
# Table name: job
#
# id					 :integer			not null, primary key
# user_id      :integer 		not null
# title        :string
# job_group_id :integer     not null
# created_at   :datetime    not null
# updated_at   :datetime    not null
#