class AddUpdatedAtToJobDescriptions < ActiveRecord::Migration
  def change
    add_column :job_descriptions, :updated_at, :datetime
  end
end
