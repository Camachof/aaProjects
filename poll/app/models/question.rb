class Question < ActiveRecord::Base

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def n_results
    choice_count = Hash.new(0)

    self.answer_choices.each do |choice|
      choice_count[choice.body] += choice.responses.count
    end

    choice_count
  end

  def better_results
    choices = self.answer_choices.includes(:responses)

    choice_count = Hash.new(0)
    choices.each do |choice|
      choice_count[choice.body] += choice.responses.length
    end

    choice_count
  end


end
