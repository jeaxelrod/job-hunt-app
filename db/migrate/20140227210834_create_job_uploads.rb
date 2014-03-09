class CreateJobUploads < ActiveRecord::Migration
  def change
    create_table :job_uploads do |t|

      t.timestamps
    end
  end
end
