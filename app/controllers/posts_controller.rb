# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:author).all
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:author).find(params[:id])
  end

  def new
    @post = current_user.posts.build
    @current_user = current_user
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@post.author, @post), notice: 'Post created successfully.'
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post # This line checks if the user is authorized to delete the post
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
