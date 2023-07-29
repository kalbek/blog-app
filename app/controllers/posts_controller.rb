# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
    # Add any additional logic you want for displaying all posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    # Add any logic you want to perform for displaying a specific user post
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

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
