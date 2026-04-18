Rails.application.routes.draw do
  get 'users/new'
  get 'sessions/new'
  root 'tasks#index'

  get    '/login',  to: 'sessions#new',     as: 'new_session'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show, :edit, :update]

  resources :tasks

  namespace :admin do
    resources :users
  end
end
