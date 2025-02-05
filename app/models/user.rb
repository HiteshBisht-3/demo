class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create_commit :new_user_welcome
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
    [ "username" ]
  end

  def new_user_welcome
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
