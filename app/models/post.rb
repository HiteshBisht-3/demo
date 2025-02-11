class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :file, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :file, presence: true
  validates :caption, length: { maximum: 2200 }

  def like_count
    likes.count
  end
end
