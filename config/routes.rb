Rails.application.routes.draw do
  devise_for :users
 
  root to: 'home#index'

  resources :categories, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :vehicles, only: [:index]

  
  
end
