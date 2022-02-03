Rails.application.routes.draw do
  root to: 'albums#index'
  
  resources :albums do
    resources :songs
  end

  resources :songs, except: [:destroy]
end
