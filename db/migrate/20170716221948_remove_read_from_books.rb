class RemoveReadFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :read
  end
end
