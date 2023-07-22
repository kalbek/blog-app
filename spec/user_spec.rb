require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter' do
    user = User.new(name: 'user-1', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'user-1', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is invalid with a non-integer posts_counter' do
    user = User.new(name: 'user-1', posts_counter: 1.5)
    expect(user).to_not be_valid
  end
end
