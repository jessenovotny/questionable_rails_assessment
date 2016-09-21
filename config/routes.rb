Rails.application.routes.draw do
  

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get '/auth/facebook/callback' => 'sessions#create'

  get '/questions/most_recent' => 'questions#index', as: :most_recent_questions

  put '/categories/:category_id/questions/:id' => 'questions#update', as: :question_category


  resources :questions, only: [:index, :show, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
    resources :favorites, only: [:create]
  end

  resources :categories, only: [] do
    resources :questions, only: [:index]
  end

  resources :answer, only: [] do
    resources :upvotes, only: [:create]
  end

  resources :users, only: [:destroy] do
    resources :questions, only: [:index, :new, :create]
    resources :answers, only: [:index]
    resources :favorites, only: [:index]
  end

  root 'questions#index'
end
