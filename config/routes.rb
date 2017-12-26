Rails.application.routes.draw do
  resources :questionnaires do
    resources :comments
    resources :answeras
    resources :answerbs
    get 'user_posteds', on: :collection
    get 'user_answereds', on: :collection
    get 'user_favorites', on: :collection
  end

  root 'questionnaires#index'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, :only => [:index, :show]
  resources :notifications, :only => [:index]
  resources :favorites


  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
