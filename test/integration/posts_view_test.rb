require 'test_helper'

class PostsViewTest < ActionDispatch::IntegrationTest
  fixtures :users, :posts, :comments

  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "visiting a user's posts index page" do
    visit user_posts_path(@user)

    # Test if one can see the user's profile picture.
    assert page.has_content?(@user.photo)

    # Test if one can see the user's username.
    assert page.has_content?(@user.name)

    # Test if one can see the number of posts the user has written.
    assert page.has_content?("Number of posts: #{users(:one).posts.count}")

    # Test if one can see a post's title.
    assert page.has_content?(@post.title)

    # Test if one can see some of the post's body.
    assert page.has_content?(@post.text)

    # Test if one can see the first comments on a post.
    assert page.has_content?(@comment.text)

    # Test if one can see how many comments a post has.
    assert page.has_content?("Comments: #{@post.comments.count}")

    # Test if one can see how many likes a post has.
    assert page.has_content?("Likes: #{@post.likes.count}")

    # Test if one can see a section for pagination if there are more posts than fit on the view. (You can add this test if applicable.)
    end
    # Test when I click on a post, it redirects me to that post's show page. 
   
    # Test when I click on a post, it redirects me to that post's show page. (You can add this test if applicable.)
end