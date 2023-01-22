Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :game_rooms do
    resources :issues
  end
  resources :pokers
  
end
