require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  # let(:user) { FactoryBot.create(:user) }

  describe 'GET /posts' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, author: @user)
    end

    # Create a Post and associate it with the User
    it 'returns http success' do
      get user_posts_path(user_id: @user.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user_id: @user.id)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user_id: @user.id)
      expect(response.body).to include('User Posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, author: @user)
    end

    it 'returns http success' do
      get user_posts_path(user_id: @user.id, post_id: @post.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(@user, @post)
      expect(response).to render_template(:show)
    end

    it 'includes correct user ID in the response body' do
      get user_post_path(@user, @post)
      # get user_post_path(user, post)
      expect(response.body).to include("User ID: #{@user.id}")
    end

    it 'includes correct post ID in the response body' do
      get user_post_path(@user, @post)
      expect(response.body).to include("Post ID: #{@post.id}")
    end

    it 'includes correct post content in the response body' do
      get user_post_path(@user, @post)
      expect(response.body).to include(@post.text)
    end
  end
end
