Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts, only: [:new, :create, :destroy]
  resources :comments, only: [:new, :create, :destroy]
  resources :likes, only: [:new, :create]

  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Defines the root path route ("/")
  root to: 'users#index'

  get 'users', to: 'users#index', as: :users

  # User profile route
  get 'users/:id', to: 'users#show', as: :user

  # User posts route
  get 'users/:user_id/posts', to: 'posts#index', as: :user_posts

  # Specific user post route
  get 'users/:user_id/posts/:id', to: 'posts#show', as: :user_post

  # API routes
  namespace :api, defaults: { format: :json } do
    resources :users, only: [] do
      resources :posts, only: :index
    end
    resources :posts, only: [] do
      resources :comments, only: :index
      resources :comments, only: :create
    end
    resources :users do
      resources :posts, only: [] do
        resources :comments, only: :index
      end
    end
    resources :posts, only: [] do
      resources :comments, only: :create
    end
  end
end
