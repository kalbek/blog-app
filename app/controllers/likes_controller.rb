class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      # Increment the likes counter of the post
      @post.increment!(:likes_counter)
      redirect_to user_post_path(user_id: @post.author.id, id: @post.id), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(user_id: @post.author.id, id: @post.id), alert: 'Error liking the post.'
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
