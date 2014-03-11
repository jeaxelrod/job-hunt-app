class Categorization < ActiveRecord::Base
  belongs_to :job
	belongs_to :job_group
end
