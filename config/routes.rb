Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :game_rooms do
    resources :issues do
      put :set_current_issue
      put :reveal_votes
    end
    resources :pokers
    resources :game_room_users, only: [:destroy]
  end

  get '/game_rooms/join/:token', to: 'game_room_users#create'
end
