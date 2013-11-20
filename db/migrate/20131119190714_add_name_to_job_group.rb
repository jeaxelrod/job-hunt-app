class AddNameToJobGroup < ActiveRecord::Migration
  def change
    add_column :job_groups, :name, :string
  end
end
