# app/controllers/posts_controller.rb
    class Api::PostsController < ApplicationController
      before_action :authenticate_user!
  
      def index
        @user = User.find(params[:user_id])
        @posts = @user.posts.includes(:author).all
    
        respond_to do |format|
          format.json { render json: @posts, status: :ok }
        end
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
  
        respond_to do |format|
          if @post.save
            format.html { redirect_to user_post_path(@post.author, @post), notice: 'Post created successfully.' }
            format.json { render json: @post, status: :created, location: user_post_path(@post.author, @post) }
          else
            format.html { flash.now[:alert] = @post.errors.full_messages.join(', '); render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
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