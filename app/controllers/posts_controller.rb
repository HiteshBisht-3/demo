class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    friends = current_user.friends

    if friends.any?
      @posts = Post.where(user_id: friends.pluck(:id)).order(created_at: :desc)
    else
      @posts = Post.order("RANDOM()").limit(10)
      flash.now[:alert] = "You are not allowed to view posts unless you have friends. Showing random posts instead."
    end
  end

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

  def destroy
    @post.destroy
    redirect_to profile_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :file)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
