require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name must not be blank' do
    user = User.new(name: '')
    assert_not user.valid?
  end

  test 'posts_counter must be an integer greater than or equal to zero' do
    user = User.new(posts_counter: -1)
    assert_not user.valid?

    user.posts_counter = 0
    assert user.valid?

    user.posts_counter = 1
    assert user.valid?

    user.posts_counter = 'not a number'
    assert_not user.valid?
  end

  test 'recent_posts returns the most recent posts' do
    user = create(:user)
    create_list(:post, 5, author: user)
    assert_equal 3, user.recent_posts.count
  end
end
