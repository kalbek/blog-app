class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :post do |t|
      t.references :author, foreign_key: { to_table: :user }
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end
