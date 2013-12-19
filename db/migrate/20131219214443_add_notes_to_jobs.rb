class AddNotesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :notes, :string
  end
end
