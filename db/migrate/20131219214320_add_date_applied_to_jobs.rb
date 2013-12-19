class AddDateAppliedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :date_applied, :date
  end
end
