class Group < ActiveRecord::Base
	belongs_to  :user
  validates :name, presence: true
	has_many :jobs , through: :categorizations
	has_many :categorizations
end

