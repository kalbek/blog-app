require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(id: 1, name: 'user-1', bio: 'user-1s bio', photo: '', posts_counter: 0)
    @post = Post.create(title: 'post-1', text: 'post text', comments_counter: 1, likes_counter: 1, author_id: @user.id)
    @comment = Comment.new(text: 'post comment', author_id: @user.id, post_id: @post.id)
  end

  describe 'after_create' do
    it 'updates the comments_counter of the associated post' do
      Comment.create(author: @user, post: @post, text: 'Test comment')
      @post.reload
      expect(@post.comments_counter).to eq(1)
    end
  end
end
