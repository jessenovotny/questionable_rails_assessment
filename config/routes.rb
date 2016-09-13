Rails.application.routes.draw do
  

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :questions, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end



  resources :users, only: [] do
    resources :questions, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home', as: :home
end
