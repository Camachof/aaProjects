class RemoveUserIdColumnFromPostingsTable < ActiveRecord::Migration
  def change
    remove_column :postings, :user_id
    add_column :postings, :sub_id, :integer, null: false
  end
end
