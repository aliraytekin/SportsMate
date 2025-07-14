Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users do
    resources :user_sports_interests, only: %i[index new create edit update destroy]
  end

  resources :events, only: %i[index show new create edit update] do
    member do
      patch :cancel_event
    end

    resources :participations, only: %i[new create]
  end

  resources :payments, only: %i[new create] do
    collection do
      post :success
      get :confirmation
    end
  end

  resources :participations, only: %i[index edit update] do
    member do
      patch :cancel_participation
      patch :refund
    end
  end
end
