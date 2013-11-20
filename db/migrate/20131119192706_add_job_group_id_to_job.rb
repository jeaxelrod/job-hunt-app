class AddJobGroupIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :job_grou_id, :integer
  end
end
