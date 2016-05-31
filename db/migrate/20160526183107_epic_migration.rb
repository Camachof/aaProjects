class EpicMigration < ActiveRecord::Migration
  def change
    drop_table :questions
    create_table :questions do |t|
      t.integer :poll_id
      t.string :body
      t.timestamps null: false
    end

    add_index :questions, :body, :unique => true

    drop_table :responses
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
      t.timestamps null: false
    end

    drop_table :answer_choices
    create_table :answer_choices do |t|
      t.integer :question_id
      t.string :body
      t.timestamps null: false
    end

    drop_table :polls
    create_table :polls do |t|
      t.string :title
      t.integer :author_id
      t.timestamps null: false
    end

    drop_table :users
    create_table :users do |t|
      t.string :name
      t.timestamps null: false
    end

    add_index :users, :name, :unique => true
  end
end
