# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    @posts = Post.all
    # Add any additional logic you want for displaying all posts
  end
  
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    # Add any logic you want to perform for displaying a specific user post
  end
end
