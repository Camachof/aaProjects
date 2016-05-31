# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create!(name: "Rent")
User.create!(name: "James")
User.create!(name: "Buck")

Poll.delete_all
Poll.create!(title: "Basic Survey", author_id: 1)
Poll.create!(title: "Some Questions", author_id: 2)

Question.delete_all
Question.create!(poll_id: 1, body: "Hey?")
Question.create!(poll_id: 2, body: "old?")
Question.create!(poll_id: 1, body: "food?")
Question.create!(poll_id: 2, body: "hat?")
Question.create!(poll_id: 2, body: "me?")

AnswerChoice.delete_all
AnswerChoice.create!(question_id: 1, body: "A")
AnswerChoice.create!(question_id: 3, body: "B")
AnswerChoice.create!(question_id: 2, body: "C")
AnswerChoice.create!(question_id: 4, body: "D")


Response.delete_all
Response.create!(user_id: 1, answer_choice_id: 4)
Response.create!(user_id: 2, answer_choice_id: 3)
Response.create!(user_id: 3, answer_choice_id: 2)
Response.create!(user_id: 1, answer_choice_id: 1)
