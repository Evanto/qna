Rails.application.routes.draw do

  resources :votes, only: [:create] do
    delete :reset, on: :collection
  end

  resources :attachments, only: :destroy
  devise_for :users

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
    end
  end

  root to: "questions#index"
end
