class AddJobIdToJobDescriptions < ActiveRecord::Migration
  def change
    add_column :job_descriptions, :job_id, :int
  end
end
