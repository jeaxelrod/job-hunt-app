class JobColumn < ActiveRecord::Base
	belongs_to :user
	has_many :job_column_contents
end

# ==Schema information
#
## Table name: job_group
#
# id          :integer    not null, primary key
# title       :string     not null
# user_id     :integer    not null
# created_at  :datetime   not null
# updated_at  :datetime   not null
#