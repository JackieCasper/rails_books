class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :pages
      t.boolean :read
      t.belongs_to :author, foreign_key: true, index: true
      t.string :genre

      t.timestamps
    end
  end
end
