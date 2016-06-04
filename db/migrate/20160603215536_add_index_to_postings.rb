class AddIndexToPostings < ActiveRecord::Migration
  def change
    add_index :postings, [:sub_id, :post_id], unique: true
  end
end
