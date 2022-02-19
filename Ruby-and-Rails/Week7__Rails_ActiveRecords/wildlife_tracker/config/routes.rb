Rails.application.routes.draw do
  root to: 'animals#index'
  resources :animals do
    resources :sights, except: %i[edit show]
  end

  resources :regions, only: %i[index new create] do
    resources :sight, only: %i[new create]
  end
end
