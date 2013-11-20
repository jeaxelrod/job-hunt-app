class CreateJobGroups < ActiveRecord::Migration
  def change
    create_table :job_groups do |t|

      t.timestamps
    end
  end
end
