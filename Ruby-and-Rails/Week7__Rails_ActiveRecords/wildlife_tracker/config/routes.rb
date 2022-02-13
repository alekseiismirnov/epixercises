Rails.application.routes.draw do
  root to: 'animals#index'
  resources :animals do
    resources :sights, except: %i[edit show]
  end
end
