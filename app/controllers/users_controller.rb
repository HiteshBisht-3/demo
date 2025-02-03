class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(posts: :comments).all
  end

  def show
    @user = User.find(params[:id])
  end
end
