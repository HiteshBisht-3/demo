class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def show
    @comments = @post.comments
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to @post
      else
        render :new
      end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def like
      like = @post.likes.find_by(user: current_user)
  end

  def destroy
    @post.destroy
    redirect_to profile_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
