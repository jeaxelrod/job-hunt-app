class Categorization < ActiveRecord::Base
  belongs_to :job
	belongs_to :group
  
  validates_presence_of :job
  validates_presence_of :group
end
