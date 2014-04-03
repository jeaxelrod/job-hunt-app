class Job < ActiveRecord::Base
	belongs_to :user
	has_many :descriptions, :dependent => :destroy, :inverse_of => :job 
  accepts_nested_attributes_for :descriptions, allow_destroy: true
	has_many :categorizations, :dependent => :destroy, :inverse_of => :job
  accepts_nested_attributes_for :categorizations, allow_destroy: true
  has_many	:groups, through: :categorizations
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates_format_of :link, allow_nil: true, allow_blank: true,
		with: /\A#{URI::regexp}\z/
  
  def nongroups
    job_groups = self.groups
    group_ids = Array.new
    job_groups.each do |group|
      group_ids << group
    end
    user.groups.where.not(id:  group_ids)
  end
end
