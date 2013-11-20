class AddJobColumnIdToJobColumnContent < ActiveRecord::Migration
  def change
    add_column :job_column_contents, :job_column_id, :integer
  end
end
