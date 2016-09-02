class Posting < ActiveRecord::Base

  validates :post, presence: "need a post id!"
  validates :sub, presence: true

  belongs_to :post, inverse_of: :postings, dependent: :destroy

  belongs_to :sub, dependent: :destroy

end
