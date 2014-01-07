class DropJobColumnContents < ActiveRecord::Migration
  def change
		drop_table :job_column_contents
  end
end
