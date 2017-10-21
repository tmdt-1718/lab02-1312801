class Message < ApplicationRecord
  mount_uploader :picture, PictureUploader
  acts_as_readable on: :created_at
   is_impressionable
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true
    has_many :impressionists
    def feed
     Message.where("user_id = ?", id)
   end
end
