Rails.application.routes.draw do
  

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get '/auth/facebook/callback' => 'sessions#create'

  get '/questions/most_recent' => 'questions#index', as: :most_recent_questions

  resources :questions, only: [:index, :show, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :categories, only: [] do
    resources :questions, only: [:index]
  end

  resources :answer, only: [] do
    resources :upvotes, only: [:create, :destroy]
  end

  resources :users, only: [] do
    resources :questions, only: [:index, :new, :create]
    resources :answers, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'questions#index'
end
