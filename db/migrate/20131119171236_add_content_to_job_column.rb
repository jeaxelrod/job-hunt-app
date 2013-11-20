class AddContentToJobColumn < ActiveRecord::Migration
  def change
    add_column :job_columns, :content, :string
  end
end
