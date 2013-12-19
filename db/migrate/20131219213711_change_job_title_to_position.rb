class ChangeJobTitleToPosition < ActiveRecord::Migration
  def change
		rename_column :jobs, :title, :position
  end
end
