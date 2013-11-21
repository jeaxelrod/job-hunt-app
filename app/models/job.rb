class Job < ActiveRecord::Base
	belongs_to :user
	belongs_to :job_group
	has_many :job_column_contents, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :job_group_id, presence: true
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