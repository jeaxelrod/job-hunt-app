class DropJobColumns < ActiveRecord::Migration
  def change
		drop_table :job_columns
  end
end
