class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
      @users = User.includes(posts: :comments).all
  end

  def show
      @user = User.find(params[:id])
      @friend_request = FriendRequest.new
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true).where.not(id: current_user.id)
  end

  def friend_requests
    @received_requests = current_user.received_friend_requests.pending
    @send_friends = current_user.sent_friend_requests.accepted
    @receive_friends = current_user.received_friend_requests.accepted
  end
end
