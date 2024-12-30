# config/routes.rb
Rails.application.routes.draw do
  root 'expenses#index'
  
  resources :expenses, only: [:create, :destroy] do
    collection do
      post 'reset'
    end
  end
  
  resources :accounts, only: [:create, :destroy]
end