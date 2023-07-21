require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'title must not be blank' do
    post = Post.new(title: '')
    assert_not post.valid?
  end

  test 'title must not exceed 250 characters' do
    post = Post.new(title: 'a' * 251)
    assert_not post.valid?
  end

  test 'comments_counter must be an integer greater than or equal to zero' do
    post = Post.new(comments_counter: -1)
    assert_not post.valid?

    post.comments_counter = 0
    assert post.valid?

    post.comments_counter = 1
    assert post.valid?

    post.comments_counter = 'not a number'
    assert_not post.valid?
  end

  test 'likes_counter must be an integer greater than or equal to zero' do
    post = Post.new(likes_counter: -1)
    assert_not post.valid?

    post.likes_counter = 0
    assert post.valid?

    post.likes_counter = 1
    assert post.valid?

    post.likes_counter = 'not a number'
    assert_not post.valid?
  end

  test 'recent_comments returns the most recent comments' do
    user = create(:user)
    post = create(:post, author: user)
    create_list(:comment, 5, post:)
    assert_equal 5, post.recent_comments.count
  end

  test 'update_posts_counter updates the posts counter of the author' do
    user = create(:user)
    assert_equal 0, user.posts_counter

    create_list(:post, 5, author: user)
    user.reload

    assert_equal 5, user.posts_counter
  end
end
