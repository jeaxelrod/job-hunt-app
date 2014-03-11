class JobGroup < ActiveRecord::Base
	belongs_to  :user
	has_many :jobs , through: :categorizations
	has_many :categorizations
end

