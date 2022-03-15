Rails.application.routes.draw do
  root to: 'teams#index'

  resources :teams do
    resources :coordinators
    resources :players
  end
end
