class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: "User"

  has_many :postings, inverse_of: :subs

  has_many :posts, through: :postings


end
