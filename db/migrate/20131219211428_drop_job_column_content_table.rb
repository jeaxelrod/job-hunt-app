class DropJobColumnContentTable < ActiveRecord::Migration
  def up
		drop_table :job_column_contents
  end
	
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
