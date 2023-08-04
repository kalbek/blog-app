class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.includes(:author, :comments).find(params[:post_id])
    @comments = @post.comments

    respond_to do |format|
      format.json { render json: @comments, status: :ok }
    end
  end

  def create
    @user = current_user
    @post = Post.find_by(id: params[:comment][:post_id])

    if @post.nil?
      respond_to do |format|
        format.html { redirect_to user_posts_path(user_id: @user), alert: 'Error adding comment: Post not found.' }
        format.json { render json: { error: 'Post not found.' }, status: :not_found }
      end
      return
    end

    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_posts_path(user_id: @user), notice: 'Comment added successfully.' }
        format.json { render json: @comment, status: :created }
      else
        format.html { redirect_to user_posts_path(user_id: @user), alert: 'Error adding comment.' }
        format.json do
          render json: { error: @comment.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path(user_id: @user), notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
