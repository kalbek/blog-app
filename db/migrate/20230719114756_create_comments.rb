class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comment do |t|
      t.references :author, foreign_key: { to_table: :user }
      t.references :post, foreign_key: { to_table: :post }
      t.text :text

      t.timestamps
    end
  end
end
