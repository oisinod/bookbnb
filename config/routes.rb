Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  resources :users, only: [:index, :show]
  resources :reviews, except: [:index, :show, :new, :create]
  resources :books do
    resources :bookings, except: [:index, :show]
  end
  resources :bookings, only: [:show, :update] do
    resources :reviews, only: [:create]
  end
  get "/dashboard", to: "pages#dashboard", as: :dashboard
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
