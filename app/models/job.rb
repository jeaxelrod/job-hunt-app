class Job < ActiveRecord::Base
	belongs_to :user
	has_many :descriptions, dependent: :destroy
	has_many :categorizations
  has_many	:groups, through: :categorizations
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates_format_of :link, allow_nil: true, allow_blank: true,
		with: /\A#{URI::regexp}\z/
		
end
