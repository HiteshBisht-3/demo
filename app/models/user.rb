class User < ApplicationRecord
  attr_accessor :login
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: "receiver_id", dependent: :destroy

  def friends
    sent_friends = FriendRequest.where(sender_id: id, status: "accepted").pluck(:receiver_id)
    received_friends = FriendRequest.where(receiver_id: id, status: "accepted").pluck(:sender_id)
    User.where(id: sent_friends + received_friends)
  end

  validates :username, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :phone, uniqueness: true, allow_blank: true

  after_create_commit :new_user_welcome

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(email) = :value OR phone = :value", { value: login.downcase }]).first
  end

  def self.ransackable_attributes(auth_object = nil)
    ["username"]
  end

  def new_user_welcome
    SendEmailsJob.perform_now(self)
  end

  def self.pick_random
    count = User.count
    return nil if count == 0  
    random_offset = rand(count)
    random_user = User.offset(random_offset).first
    random_user
  end
end
