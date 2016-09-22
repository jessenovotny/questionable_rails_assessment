Rails.application.routes.draw do
  
  root 'questions#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  delete 'logout' => 'sessions#destroy'
  
  get '/auth/facebook/callback' => 'sessions#create'

  get '/questions/most_recent' => 'questions#index', as: :most_recent_questions
  get '/questions/most_popular' => 'questions#index', as: :most_popular_questions
  get '/questions/top_answers' => 'questions#index', as: :top_answers
  get '/questions/oldest' => 'questions#index', as: :oldest_questions

  put '/categories/:category_id/questions/:id' => 'questions#update', as: :question_category


  resources :questions, only: [:index, :show] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
    resources :favorites, only: [:create]
  end

  resources :answer, only: [] do
    resources :upvotes, only: [:create]
  end

  resources :users, only: [:destroy] do
    resources :questions, only: [:new, :create, :edit, :update, :destroy]
    resources :answers, only: [:index]
    resources :favorites, only: [:index]
  end

end
