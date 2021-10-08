Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#home'
  get '/timeline', to: 'static_pages#timeline'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  resources :relationships, only: [:create, :destroy]
  resources :users do 
    member do
      get :following, :followers
    end
  end
  resources :posts do
    post :preview, action: :preview_new, on: :new
    get :preview, action: :preview_new, on: :new
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
