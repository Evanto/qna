Rails.application.routes.draw do
  # вложенные ресурсы: ответ вложен в вопрос
  resources :questions, shallow: true do
    resources :answers
  end
end
