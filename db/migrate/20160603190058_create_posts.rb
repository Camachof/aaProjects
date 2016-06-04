class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :content, null: false
      t.integer :posting_id, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end

    add_index :posts, [:posting_id, :author_id]
  end
end
