class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable
  
  validates :image, presence: true
  validates :caption, length: { maximum: 2200 }

  def like_count
    likes.count
  end

end
