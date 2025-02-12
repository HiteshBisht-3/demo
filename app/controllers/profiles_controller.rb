class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    
    # Check if current_user is friends with @user
    if current_user.friends.include?(@user)
      @posts = @user.posts  # Show posts only if they are friends
    else
      @posts = []  # Empty array if they are not friends
    end
  end
end