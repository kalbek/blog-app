# test/integration/users_view_test.rb

require 'test_helper'

class UsersViewTest < ActionDispatch::IntegrationTest
  fixtures :users, :posts
  setup do
    @user = users(:one)
  end

  test "visiting the users index page" do
    visit users_path

    # Test if I can see the username of all other users
    assert page.has_content?(@user.name)

    # Check if the profile picture is displayed for each user
    assert page.has_content?(@user.photo)
    
    # Test if the number of posts each user has written can be seen.
    assert page.has_content?("Number of posts:#{@user.posts_counter}")

    # Test clicking on a user's name redirects to their show page
    click_on "user-link-#{@user.id}"
    assert_current_path(user_path(@user))
  end

  test "visiting a user's show page" do
    visit user_path(@user)

    # Test if one can see the user's username.
    assert page.has_content?(@user.name)

    # Test if one can see the user's profile picture.
    # assert page.has_css?(".user-photo img[src='#{@user.photo}']")

    # Test if one can see the user's username.
    assert page.has_content?(@user.name)

    # Test if one can see the number of posts the user has written.
    assert page.has_content?("Number of posts: #{users(:one).posts.count}")

    # Test if one can see the user's bio.
    assert page.has_content?(@user.bio)

    # Test if one can see the user's first 3 posts.
    @user.recent_posts.limit(3).each do |post|
      assert page.has_content?(post.title)
    end

    # Test if one I click a user's post, it redirects me to that post's show page.
    click_on "user-post-link-#{@user.id}"
    assert_current_path(user_post_path(@user, users(:one).posts.first))
    
    # Test if one I click "Comment on this post", it redirects me to the comment creation page.
    click_on "Comment on this post"
    assert_current_path(new_comment_path(user_id: @user.id, post_id: users(:one).posts.first.id))
  end
end
