class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, as: :likeable , dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  # validates :username, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  
end
