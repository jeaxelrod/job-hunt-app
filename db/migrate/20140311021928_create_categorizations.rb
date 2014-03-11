class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :job_group_id
      t.integer :job_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
