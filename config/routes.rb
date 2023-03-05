Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :game_rooms do
    resources :issues do
      resource :revotes, only: %i[new update], controller: 'issues/revotes'
      resource :reveal_votes, only: %i[new update], controller: 'issues/reveal_votes'
      put :set_current_issue
    end
    resources :pokers
    resources :game_room_users, only: [:destroy]
    resource :user_roles, only: %i[create destroy]
  end

  get '/game_rooms/join/:token', to: 'game_room_users#create'
end
