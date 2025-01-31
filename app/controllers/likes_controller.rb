class LikesController < ApplicationController
  before_action :find_post

  def create
    @like = @post.likes.create(user: current_user)
    redirect_to @post
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like.destroy if @like
    redirect_to @post
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end
end
