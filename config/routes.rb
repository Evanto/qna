Rails.application.routes.draw do
  devise_for :users
  # вложенные ресурсы: ответ вложен в вопрос
  resources :questions, shallow: true do
    resources :answers
  end

  root to: "questions#index"
end
