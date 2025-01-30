class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :caption, presence: true, length: { maximum: 2200 }

end
