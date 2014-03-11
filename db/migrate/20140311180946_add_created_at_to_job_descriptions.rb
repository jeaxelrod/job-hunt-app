class AddCreatedAtToJobDescriptions < ActiveRecord::Migration
  def change
    add_column :job_descriptions, :created_at, :datetime
  end
end
