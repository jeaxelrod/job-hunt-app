class RenameJobGroupIdToGroupIdInCategorizations < ActiveRecord::Migration
  def change
	  rename_column :categorizations, :job_group_id, :group_id
  end
end
