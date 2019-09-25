Rails.application.routes.draw do
  get 'home/index'
  get '/home/about', to:"home#about", as:"about"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users, only: [:index, :show, :edit, :update]
  resources :books
end
