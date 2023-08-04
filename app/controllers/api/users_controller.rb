# app/controllers/users_controller.rb
class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:posts).all
    render json: @users
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @users = User.all
    render json: @users
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render json: @posts
  end
end
