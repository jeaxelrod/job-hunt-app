class JobColumnContent < ActiveRecord::Base
end

# ==Schema Information
#
# Table name: job_column_content
# id             :integer     not null, primary key
# content        :string      
# job_column_id  :integer     not null
# created_at     :datetime    not null
# updated_at     :datetime    not null
# ADD JOB_ID
#