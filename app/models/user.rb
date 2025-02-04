class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: "receiver_id", dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def self.ransackable_attributes(auth_object = nil)
    # Only allow specific, non-sensitive attributes to be searchable
    [ "username", "email", "first_name", "last_name" ]
  end

  # Optional: If you want to allow searching through associations
  def self.ransackable_associations(auth_object = nil)
    [ "posts", "comments" ] # Add any associations you want to be searchable
  end
end
