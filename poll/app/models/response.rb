class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true

  validate :no_double_answering

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def sibling_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  def no_double_answering
    if sibling_already_answered?
      errors[:answered] << "Can't answer same question"
    end
  end

  def cheating?
    question.poll.author_id == user_id
  end



end
