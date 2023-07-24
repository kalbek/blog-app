Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Homepage route
  get 'users', to: 'home#index', as: :users

  # User profile route
  get 'users/:id', to: 'users#show', as: :user

  # User posts route
  get 'users/:user_id/posts', to: 'posts#index', as: :user_posts

  # Specific user post route
  get 'users/:user_id/posts/:id', to: 'posts#show', as: :user_post
end
