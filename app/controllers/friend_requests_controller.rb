class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)
    
    if @friend_request.save
      redirect_to request.referrer, notice: 'Friend request sent successfully!'
    else
      redirect_to request.referrer, alert: 'Failed to send friend request.'
    end
  end

  def accept
    @friend_request = FriendRequest.find(params[:id])
    
    if @friend_request.receiver == current_user
      @friend_request.update(status: :accepted)
      redirect_to friend_requests_user_path(current_user), notice: 'Friend request accepted!'
    else
      redirect_to friend_requests_user_path(current_user), alert: 'Unauthorized action.'
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    
    if @friend_request.receiver == current_user
      @friend_request.destroy
      redirect_to user_friend_requests_path(current_user), notice: 'Friend request rejected.'
    else
      redirect_to user_friend_requests_path(current_user), alert: 'Unauthorized action.'
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:receiver_id)
  end
end