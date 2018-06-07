Rails.application.routes.draw do
  resources :articles do
    member do
      get 'delete'
    end
  end

  root 'articles#index'
end
