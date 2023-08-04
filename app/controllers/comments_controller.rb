class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.includes(:author, :comments).find(params[:post_id])
    @comment = current_user.comments.build
    @current_user = current_user
  end

  def create
    @user = current_user
    @post = Post.find_by(id: params[:comment][:post_id])
    if @post.nil?
      redirect_to posts_url, alert: 'Error adding comment: Post not found.'
      return
    end
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_posts_path(user_id: @user), notice: 'Comment added successfully.'
    else
      redirect_to user_posts_path(user_id: @user), alert: 'Error adding comment.'
    end
  end

  
  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy
    # redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted.'
    redirect_to user_posts_path(user_id: @user), alert: 'Error adding comment.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
