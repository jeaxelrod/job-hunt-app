class RenameJobDescriptionToDescription < ActiveRecord::Migration
  def change
	  rename_table :job_descriptions, :descriptions
  end
end
