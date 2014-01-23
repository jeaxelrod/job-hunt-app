class Job < ActiveRecord::Base
	belongs_to :user
	belongs_to :job_group
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :job_group_id, presence: true
	validates_format_of :link, allow_nil: true, allow_blank: true,
		with: /\A#{URI::regexp}\z/
end


# == Schema Information
#
# Table name: job
#
# id					 :integer			not null, primary key
# user_id      :integer 		not null
# job_group_id :integer     not null
# position     :string
# company      :string
# location     :string
# applied      :boolean
# date_applied :date
# notes        :string
# description  :string
# link         :string
# created_at   :datetime    not null
# updated_at   :datetime    not null
# TO ADD DATE ADDED NAH
# TO ADD LINK