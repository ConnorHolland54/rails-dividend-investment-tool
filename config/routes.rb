Rails.application.routes.draw do
  resources :port_stocks
  resources :stocks
  resources :portfolios do
    resources :stocks, only: [:index, :new]
  end

  resources :users do
    resources :portfolios
    resources :stocks
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  delete '/portfolios/:portfolio_id/stocks/remove', to: "port_stocks#remove"
  patch '/port_stocks', to: 'port_stocks#update_stock'

  get "/auth/facebook/callback", to: "omniauth_callbacks#facebook"
end
