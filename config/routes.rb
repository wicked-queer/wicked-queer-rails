Rails.application.routes.draw do
  get 'home/index'

  resources :events, only: [:index, :show]
  resources :festival, only: [:index, :show]
  resources :series, only: [:show]

  get '/:id', to: 'pages#show'

  root 'home#index'
end
