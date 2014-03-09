class AddAttributesToJobUploads < ActiveRecord::Migration
  def change
    add_column :job_uploads, :job_id, :int
    add_column :job_uploads, :upload_file_name, :str
    add_column :job_uploads, :upload_content_type, :int
    add_column :job_uploads, :upload_file_size, :int
    add_column :job_uploads, :upload_updated_at, :datetime
  end
end
