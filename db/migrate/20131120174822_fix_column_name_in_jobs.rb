class FixColumnNameInJobs < ActiveRecord::Migration
  def change
		rename_column :jobs, :job_grou_id, :job_group_id
  end
end
