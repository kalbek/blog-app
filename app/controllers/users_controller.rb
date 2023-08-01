# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end
end
