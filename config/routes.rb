Rails.application.routes.draw do
  devise_for :users
 
  root to: 'home#index'

  resources :categories, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do
    get  'list',        on: :collection
    post 'maintenance', on: :member
    post 'operation',   on: :member
  end

  resources :mode_transports, only: [:index, :new, :create, :show, :edit, :update] do
    resources :deadlines, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :prices, only: [:index, :new, :create, :edit, :update, :destroy]
    get 'consult', on: :collection
    get 'details', on: :member
  end

  resources :orders, only: [ :index, :new, :create, :show, :edit, :update  ] do
    get 'budget', on: :member
  end

  resources :delivery_order, only: [:show, :index, :edit, :update] do
    post 'start_budget', on: :member
    get 'pesq_budget', on: :collection
    get 'closed_budget', on: :collection
    get 'no_budget_delivery', on: :member
  end
  
end
