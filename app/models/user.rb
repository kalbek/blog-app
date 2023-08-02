class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include Devise modules for authentication and others as needed
  devise :database_authenticatable, :registerable, :confirmable, :recoverable,
         :rememberable, :validatable, :timeoutable,
         stretches: 13,  # Cost of the hashing algorithm (default is 11)
         pepper: "some_pepper_value",  # Custom pepper value for hashing (optional)
         confirm_within: 3.days,  # Expiration period for account confirmation (default is nil)
         remember_for: 2.weeks,  # Expiration period for the "remember me" feature (default is 2.weeks)
         timeout_in: 30.minutes  # Period of inactivity before a user is automatically logged out (default is nil)

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
