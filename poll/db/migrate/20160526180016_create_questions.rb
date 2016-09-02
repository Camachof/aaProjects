class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id
      t.string :body
      t.timestamps null: false
    end

    add_index :questions, :body, :unique => true
  end
end
