Rails.application.routes.draw do
  resources :articles do
    get 'delete', on: :member
  end

  root 'articles#index'
end
