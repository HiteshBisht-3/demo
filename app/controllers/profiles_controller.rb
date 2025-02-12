class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
        if current_user.friends.include?(@user)
      @posts = @user.posts
    else
      @posts = []
    end
  end
end