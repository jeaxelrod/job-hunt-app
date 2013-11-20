class AddJobIdToJobColumnContent < ActiveRecord::Migration
  def change
    add_column :job_column_contents, :job_id, :integer
  end
end
