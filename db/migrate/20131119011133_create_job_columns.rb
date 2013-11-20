class CreateJobColumns < ActiveRecord::Migration
  def change
    create_table :job_columns do |t|
      t.integer :job_id

      t.timestamps
    end
  end
end
