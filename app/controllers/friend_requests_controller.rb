class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    receiver = User.find(params[:id])
    if current_user==receiver
      flash[:alert] = "Friend request already sent."
      redirect_to user_path(current_user)
    end
    friend_requests = current_user.sent_friend_requests.new(receiver: receiver, status: 'pending')
    if friend_requests.save?
      flash[:notice] = "Friend request sent!"
      redirect_to user_path(receiver)
    else
      flash[:alert] = "Failed to send friend request."
      redirect_to user_path(current_user)
    end
  end

  def accept
    
  end

  def reject
   
  end
end
