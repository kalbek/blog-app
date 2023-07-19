class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :like do |t|
      t.references :author, foreign_key: { to_table: :user }
      t.references :post, foreign_key: { to_table: :post }

      t.timestamps
    end
  end
end
