class CreateCorrectJobUploads < ActiveRecord::Migration
  def change
    create_table :job_uploads do |t|
      t.integer :job_id
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at
			t.timestamps
    end
  end
end
