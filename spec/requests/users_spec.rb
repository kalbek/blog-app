# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns http success" do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get users_path
      expect(response).to render_template(:index)
    end

    it "includes correct placeholder text in the response body" do
      get users_path
      expect(response.body).to include("Welcome to Blog App")
    end
  end

  describe "GET /users/:id" do
    before do
      @user = FactoryBot.create(:user) 
    end

    it "returns http success" do
      get user_path(@user)
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get user_path(@user)
      expect(response).to render_template(:show)
    end

    it "includes correct user ID in the response body" do
      get user_path(@user)
      expect(response.body).to include("User ID: #{@user.id}")
    end
  end
end
