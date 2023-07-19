class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :like do |t|
      t.references :author, foreign_key: { to_table: :user }
      t.references :post, foreign_key: { to_table: :post }

      t.timestamps
    end

    unless index_exists?(:like, :author_id)
      add_index :like, :author_id
    end

    unless index_exists?(:like, :post_id)
      add_index :like, :post_id
    end
  end
end
