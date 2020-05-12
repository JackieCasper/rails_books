class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :user, foreign_key: true, index: true
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
