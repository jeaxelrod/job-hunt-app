class AddUserIdToJobGroups < ActiveRecord::Migration
  def change
    add_column :job_groups, :user_id, :integer
  end
end
