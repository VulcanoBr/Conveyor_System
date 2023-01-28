Rails.application.routes.draw do
  devise_for :users
 
  root to: 'home#index'

  resources :categories, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do
    get  'list',        on: :collection
    post 'maintenance', on: :member
    post 'operation',   on: :member
  end

  resources :mode_transports, only: [:index, :new, :create, :show, :edit, :update]

  
  
end
