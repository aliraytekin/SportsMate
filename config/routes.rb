Rails.application.routes.draw do
  devise_for :users,
      controllers: {
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  root to: "pages#home"

  resources :users do
    resources :follows, only: %i[create]

    member do
      get :chat
    end
  end

  resources :messages, only: %i[create]
  resources :user_sport_interests, only: %i[index new create edit update destroy]

  resources :follows, only: %i[destroy]

  resources :events, only: %i[index show new create edit update] do
    member do
      patch :cancel_event
    end

    resources :comments, only: %i[create]

    resources :participations, only: %i[new create]

    resources :payments, only: [] do
      collection do
        get :payment
        post :success
        get :confirmation
      end
    end
  end

  resources :notifications, only: [] do
    collection do
      patch :mark_as_read
    end
  end

  resources :participations, only: %i[index show edit update] do
    member do
      patch :cancel_participation
      patch :refund
    end
  end
end
