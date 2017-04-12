Rails.application.routes.draw do
  root "schedules#index"
  get "about"     => "static_pages#about"
  get "contact"   => "static_pages#contact"
  get "promotion" => "static_pages#promotion"
  get "info" => "static_pages#info"
  get "member" => "static_pages#member"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users, only: [:show, :edit, :update]
  resources :flights, only: [:index, :show]
  resources :tickets, only: [:index, :show]
  resources :carts, only: [:index]
  resources :tickets, only: [:index, :update]
  resources :cart_infos, only: [:create]
  resources :schedules, only: :index
  resources :buy_tickets, only: [:index, :create]
  resources :buy_many_tickets, only: [:index, :create]
  resources :swap_tickets, only: [:index, :update]

  namespace :admin do
    root "dashboards#index"
    resources :companies
    resources :flights
    resources :carts
    resources :places
    resources :planes
    resources :tickets
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :manage_flights, only: :update
    resources :manage_planes, only: :update
  end
end
