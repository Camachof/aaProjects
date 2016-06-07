class Goal < ActiveRecord::Base

  validates :title, :body, :status, :confidential, presence: true
  belongs_to :user
  
end
