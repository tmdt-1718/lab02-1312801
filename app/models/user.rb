class User < ApplicationRecord
    acts_as_reader
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :messages, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  def self.reader_scope
    where(is_admin: true)
  end
  def feed
    Message.where("user_id = ?", id)
  end
  def self.from_omniauth(auth)
     where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.name = auth.info.name
       user.oauth_token = auth.credentials.token
       user.oauth_expires_at = Time.at(auth.credentials.expires_at)
       user.save!
     end
   end
end
