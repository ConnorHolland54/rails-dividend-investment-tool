Rails.application.routes.draw do
  resources :port_stocks
  resources :stocks
  resources :portfolios do
    resources :stock, only: [:index]
  end
  resources :users do
    resources :portfolios
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
