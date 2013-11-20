class AddTitleToJobColumn < ActiveRecord::Migration
  def change
    add_column :job_columns, :title, :string
  end
end
