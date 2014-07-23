RushRankerRails::Application.routes.draw do
   get "rushees/new"
   resources :users do
      member do
         get :following
      end
   end
   resources :sessions, only: [:new, :create, :destroy]
   resources :rushees do
      member do
         get :followers
      end
   end
   resources :comments, only: [:create, :destroy]
   resources :scores, only: [:update]
   resources :relationships, only: [:create, :destroy]
   root 'static_pages#home'
   match '/game',     to: 'static_pages#game',      via: 'get'
   match '/signup',   to: 'users#new',              via: 'get'
   match '/signin',   to: 'sessions#new',           via: 'get'
   match '/signout',  to: 'sessions#destroy',       via: 'delete'
   match '/about',    to: 'static_pages#about',     via: 'get'
   match '/contact',  to: 'static_pages#contact',   via: 'get'
end