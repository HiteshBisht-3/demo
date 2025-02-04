class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  enum :status, [ :pending, :accepted, :rejected ]

  validates :sender_id, uniqueness: { scope: :receiver_id, message: "Friend request already sent" }
end
