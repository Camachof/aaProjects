class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true
  validates :contact_id, presence: true, uniqueness: {scope: :user_id}

  belongs_to :user

  belongs_to :contact
end
