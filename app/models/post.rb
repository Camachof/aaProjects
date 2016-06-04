class Post < ActiveRecord::Base

  validates :title, :content, :author, presence: true

  belongs_to :author,
    class_name: 'User'

  has_many :postings,
    primary_key: :id,
    foreign_key: :post_id,
    inverse_of: :post

  has_many :subs,
    through: :postings,
    source: :sub

end
