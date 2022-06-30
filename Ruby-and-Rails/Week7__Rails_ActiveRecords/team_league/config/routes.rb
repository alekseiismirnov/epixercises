Rails.application.routes.draw do
  root to: 'teams#index'

  resources :teams do
    resources :coordinators
    resources :players
  end

  resources :games, only: %i[new create]

  resources :tournaments, only: %i[new create show]
end
