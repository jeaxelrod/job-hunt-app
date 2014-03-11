class RemoveJobGroupIdFromJob < ActiveRecord::Migration
  def change
    remove_column :jobs, :job_group_id, :int
  end
end
