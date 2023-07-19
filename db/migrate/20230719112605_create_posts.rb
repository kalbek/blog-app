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
    
    # Index for foreign key column "author_id"
    unless index_exists?(:post, :author_id)
      add_index :post, :author_id 
    end
  end
end
