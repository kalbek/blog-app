class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build
    @current_user = current_user
    puts "post_id in new action: #{@post_id}" # Add this line to check the post_id value
  end

  def create
    @user = current_user
    @post = Post.find_by(id: params[:comment][:post_id])
    if @post.nil?
      # Handle the case when the post is not found
      redirect_to posts_url, alert: 'Error adding comment: Post not found.'
      return
    end
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_posts_path(user_id: @user), notice: 'Comment added successfully.'
    else
      # Handle validation errors or other errors
      redirect_to user_posts_path(user_id: @user), alert: 'Error adding comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
