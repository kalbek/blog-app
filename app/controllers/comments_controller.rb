class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build
    @current_user = current_user
  end

  def create
    puts "postttttttttt: #{params[:post_id]}"
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Comment added successfully.'
    else
      # Handle validation errors or other errors
      redirect_to @post, alert: 'Error adding comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end    
end