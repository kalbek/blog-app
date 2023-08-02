Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts, only: [:new, :create]
  resources :comments, only: [:new, :create]
  resources :likes, only: [:new, :create]

  # Defines the root path route ("/")
  root "users#index"

  get 'users', to: 'users#index', as: :users

  # User profile route
  get 'users/:id', to: 'users#show', as: :user

  # User posts route
  get 'users/:user_id/posts', to: 'posts#index', as: :user_posts

  # Specific user post route
  get 'users/:user_id/posts/:id', to: 'posts#show', as: :user_post
end
