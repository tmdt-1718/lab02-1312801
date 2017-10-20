class Message < ApplicationRecord
  acts_as_readable on: :created_at
   is_impressionable
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true
    has_many :impressionists

end
