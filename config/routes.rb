Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users do
    resources :user_sports_interests, only: %i[index new create edit update destroy]
  end

  resources :events, only: %i[index show new create edit create edit update] do
    member do
      patch :cancel
      get :payment
      post :success
      get :confirmation
    end
  end

  resources :participants, only: %i[] do
    member do
      patch :cancel
      patch :refund
    end
  end
end
