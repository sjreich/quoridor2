Rails.application.routes.draw do
  resources :games do
    resources :moves, only: [:create]
  end
end
