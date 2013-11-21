class AddUserIdToJobColumn < ActiveRecord::Migration
  def change
		add_column :job_columns, :user_id, :integer
  end
end
