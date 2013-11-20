class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id

      t.timestamps
    end
		add_index :jobs, [:user_id, :created_at]
  end
end
