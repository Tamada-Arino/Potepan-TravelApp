Rails.application.routes.draw do

  get 'rooms/index'
  get 'users/show'
  devise_for :users
  get 'rooms/own'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :rooms do
    collection do
      post 'search'
    end
  end
  resources :reservations
  post 'reservations/confirm'
  get 'reservations/index'
  
  resources :users
  get 'users/index'
  get 'users/profile'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
