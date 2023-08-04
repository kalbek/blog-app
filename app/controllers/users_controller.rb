# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @users = User.all
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end
end