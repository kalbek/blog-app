# test/integration/users_view_test.rb

require 'test_helper'

class UsersViewTest < ActionDispatch::IntegrationTest
  fixtures :users, :posts
  setup do
    @user = users(:one)
    puts "@userrrrrrrrrr: #{@user.name}"
    puts "@userrrrrrrrrr: #{@user.posts.count}"
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

    # Test if one can see the user's profile picture.

    # Test if one can see the user's username.

    # Test if one can see the number of posts the user has written.

    # Test if one can see the user's bio.

    # Test if one can see the user's first 3 posts.

    # Test if one can see a button that lets me view all of a user's posts.

    # Test if one I click a user's post, it redirects me to that post's show page.

    # Test if one I click to see all posts, it redirects me to the user's post's index page.
    

    assert page.has_content?(@user.name)
    assert page.has_content?("Number of posts: #{@user.posts_counter}")
  end
end
