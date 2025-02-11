class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    receiver = User.find(params[:receiver_id])
    existing_request = FriendRequest.find_by(sender: current_user, receiver: receiver)

    if existing_request.nil?
      @friend_request = current_user.sent_friend_requests.create(receiver: receiver)
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Friend request already sent!"
    end
    redirect_back(fallback_location: users_path)
  end

  def accept
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.receiver == current_user
      @friend_request.update(status: "accepted")
      flash[:notice] = "Friend request accepted!"
    else
      flash[:alert] = "Unauthorized action!"
    end
    redirect_back(fallback_location: users_path)
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.receiver == current_user || @friend_request.sender == current_user
      @friend_request.destroy
      flash[:notice] = "Friend request canceled/rejected!"
    else
      flash[:alert] = "Unauthorized action!"
    end
    redirect_back(fallback_location: users_path)
  end
end
