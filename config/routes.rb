Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root controller: 'home', action: :index

  get 'connecting' => 'connecting#index'
  get 'schema' => 'schema#index'
  resources :questions
  resources :coding_challenge, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :tacos, only: [:index]
      resources :salsas, only: [:index]
      resources :search, only: [:index]
    end
  end
end
