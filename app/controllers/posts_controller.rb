# app/controllers/posts_controller.rb
class PostsController < ApplicationController
    def show
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:id])
      # Add any logic you want to perform for displaying a specific user post
    end
  end
  