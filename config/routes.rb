Rails.application.routes.draw do
  resources :game_rooms
  resources :pokers
  root 'home#index'
  
  devise_for :users
end
