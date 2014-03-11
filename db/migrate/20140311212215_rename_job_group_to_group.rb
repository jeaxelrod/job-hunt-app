class RenameJobGroupToGroup < ActiveRecord::Migration
  def change
	  rename_table :job_groups, :groups
  end
end
