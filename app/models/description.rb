class Description < ActiveRecord::Base
  belongs_to :job
  
  validates :category, presence: true
  validates_presence_of :job
end