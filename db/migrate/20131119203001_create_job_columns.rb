class CreateJobColumns < ActiveRecord::Migration
	def change
		create_table :job_columns do |t|
			t.string :title
			t.timestamps
		end
	end
end
