class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :postings, [:post_id, :user_id], unique: true
  end
end
