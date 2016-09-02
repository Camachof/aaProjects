require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname

def karma
  karma_num = PlayDBConnection.instance.execute(<<-SQL, @id)
    SELECT
      COUNT(*)/COUNT(DISTINCT questions.id)
    FROM
      questions
    LEFT OUTER JOIN question_likes
      ON questions.id = question_likes.question_id
    GROUP BY
      questions.id
    HAVING
      question_likes.user_id = ?

  SQL
  karma_num
end

  def save
    if @id.nil?
      PlayDBConnection.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = PlayDBConnection.instance.last_insert_row_id
    end


  end

  def self.find_by_id(id)
    user = PlayDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = PlayDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(user.first)
  end

  def self.all
    user_data = PlayDBConnection.instance.execute("select * from users")
    user_data.map { |datum| User.new(datum) }
  end

  def initialize(user_hash)
    @id = user_hash['id']
    @fname = user_hash['fname']
    @lname = user_hash['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionsFollow.followed_questions_for_user_id(@id)
  end

end

class Question

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionsFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionsFollow.most_followed_questions(n)
  end

  def self.find_by_id(id)
    question = PlayDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Question.new(question.first)
  end

  def self.find_by_title(title)
    question = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        title = ?
    SQL

    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    question = PlayDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    Question.new(question.first)
  end

  def self.all
    question_data = PlayDBConnection.instance.execute("select * from questions")
    question_data.map { |datum| Question.new(datum) }
  end

  def initialize(user_hash)
    @id = user_hash['id']
    @title = user_hash['title']
    @body = user_hash['body']
    @user_id = user_hash['user_id']
  end

end

class QuestionsFollow

  def self.all
    questions_follows_data = PlayDBConnection.instance.execute("select * from questions_follows")
    questions_follows_data.map { |datum| QuestionsFollow.new(datum) }
  end

  def initialize(user_hash)
    @question_id = user_hash['question_id']
    @user_id = user_hash['user_id']
  end

  #fetches 'n' most-followed-questions
  def self.most_followed_questions(n)
    most_followed_questions = PlayDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        questions_follows ON questions.id = questions_follows.question_id
      GROUP BY
        questions_follows.question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?

    SQL

    most_followed_questions.map {|question| Question.new(question)}
  end


  def self.followers_for_question_id(question_id)
    question_followers = PlayDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN questions_follows
        ON users.id = questions_follows.user_id
      WHERE
        questions_follows.question_id = ?
    SQL

    question_followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    followed_questions = PlayDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN questions_follows
        ON questions.id = questions_follows.question_id
      WHERE
        questions_follows.user_id = ?
    SQL

    followed_questions.map { |question| Question.new(question) }
  end

end

class Reply

  def author
    User.find_by_user_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_parent_reply_id(@parent_reply_id)
  end

  def child_replies
    child_replies = PlayDBConnection.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
  SQL

    child_replies.map {|child_reply| Reply.new(child_reply)}
  end

  def self.find_by_user_id(user_id)
    reply = PlayDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    reply = PlayDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    Reply.new(reply.first)
  end

  def self.find_by_id(id)
    reply = PlayDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply.first)
  end

  def self.find_by_parent_reply_id(parent_id)
    reply = PlayDBConnection.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    Reply.new(reply.first)
  end

  def self.all
    replies_data = PlayDBConnection.instance.execute("select * from replies")
    replies_data.map { |datum| Reply.new(datum) }
  end

  def initialize(user_hash)
    @id = user_hash['id']
    @parent_reply_id = user_hash['parent_reply_id']
    @user_id = user_hash['user_id']
    @question_id = user_hash['question_id']
    @body = user_hash['body']
  end
end

class QuestionLike

  def self.find_by_id(id)
    like = PlayDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(like.first)
  end

  def self.most_liked_questions(n)
    most_liked_questions = PlayDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?

    SQL

    most_liked_questions.map {|question| Question.new(question)}
  end

  def self.all
    likes_data = PlayDBConnection.instance.execute("select * from question_likes")
    likes_data.map { |datum| QuestionLike.new(datum) }
  end

  def initialize(user_hash)
    @id = user_hash['id']
    @user_id = user_hash['user_id']
    @question_id = user_hash['question_id']
    @like_val = user_hash['like_val']
  end

  def self.likers_for_question_id(question_id)
    reply = PlayDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.like_val = 'true' AND question_likes.question_id = ?
      GROUP BY
        users.id
    SQL

    reply.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    reply = PlayDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS count
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.user_id
      WHERE
        question_likes.like_val = 'true' AND question_likes.question_id = ?
      GROUP BY
        questions.id
    SQL

    reply.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = PlayDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.user_id
      WHERE
        question_likes.user_id = ? AND question_likes.like_val = 'true'
      GROUP BY
        questions.id
    SQL

    liked_questions.map { |question| Question.new(question) }
  end
end
