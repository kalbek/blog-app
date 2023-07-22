require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title, author, comments_counter, and likes_counter' do
    author = User.create(name: 'author-1')
    post = Post.new(title: 'post-1', text: 'post text', author: author, comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    author = User.create(name: 'author-1')
    post = Post.new(text: 'post text', author: author, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a title longer than 250 characters' do
    author = User.create(name: 'author-1')
    post = Post.new(title: 'a' * 251, text: 'post text', author: author, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a non-integer comments_counter' do
    author = User.create(name: 'author-1')
    post = Post.new(title: 'post-1', text: 'post text', author: author, comments_counter: 1.5, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a negative likes_counter' do
    author = User.create(name: 'author-1')
    post = Post.new(title: 'post-1', text: 'post text', author: author, comments_counter: 0, likes_counter: -1)
    expect(post).to_not be_valid
  end

  it 'is invalid with a non-integer likes_counter' do
    author = User.create(name: 'author-1')
    post = Post.new(title: 'post-1', text: 'post text', author: author, comments_counter: 0, likes_counter: 1.5)
    expect(post).to_not be_valid
  end
end
