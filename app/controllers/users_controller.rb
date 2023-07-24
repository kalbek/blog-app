# app/controllers/users_controller.rb
class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      # Add any logic you want to perform for the user profile page
    end
  
    def posts
      @user = User.find(params[:user_id])
      @posts = @user.posts
      # Add any logic you want to perform for displaying user posts
    end
  end
  