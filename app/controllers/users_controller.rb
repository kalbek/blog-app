# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end
end
