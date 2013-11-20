class CreateJobColumnContents < ActiveRecord::Migration
  def change
    create_table :job_column_contents do |t|
      t.string :content

      t.timestamps
    end
  end
end
