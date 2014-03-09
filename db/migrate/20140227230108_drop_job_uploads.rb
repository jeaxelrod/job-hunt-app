class DropJobUploads < ActiveRecord::Migration
  def change
  	drop_table :job_uploads
  end
end
