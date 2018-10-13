Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :beers
  resources :breweries
  resources :places, only: [:index, :show]

  post 'places', to:'places#search'

  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
