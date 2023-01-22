Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :game_rooms do
    resources :issues do
      post :set_current_issue
    end
    resources :pokers
  end
  
end
