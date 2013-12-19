class DropJobColumnTable < ActiveRecord::Migration
  def up
		drop_table :job_columns
  end
	def down
		raise ActiveRecord::IrreversibleMigration
	end
end
