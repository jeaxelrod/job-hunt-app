class CreateJobDescription < ActiveRecord::Migration
  def change
    create_table :job_descriptions do |t|
      t.string :content
      t.string :category
    end
  end
end
