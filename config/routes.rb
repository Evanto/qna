Rails.application.routes.draw do

  resources :comments, only: [:create]

  resources :votes, only: [:create] do
    delete :reset, on: :collection
  end

  resources :attachments, only: :destroy

  devise_for :users

  resources :questions do
    resources :comments, only: :create, defaults: { commentable: 'questions' }
    resources :answers, shallow: true do
      resources :comments, only: :create, defaults: { commentable: 'answers' }
      patch :set_best, on: :member
    end
  end

  root to: "questions#index"

  mount ActionCable.server => '/cable'
end
