class AddAppliedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :applied, :boolean
  end
end
