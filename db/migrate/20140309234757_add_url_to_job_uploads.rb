class AddUrlToJobUploads < ActiveRecord::Migration
  def change
    add_column :job_uploads, :url, :string
  end
end
