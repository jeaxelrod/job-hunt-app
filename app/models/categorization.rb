class Categorization < ActiveRecord::Base
  belongs_to :job
	belongs_to :group
end
