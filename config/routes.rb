Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "splash#index"
  resources :main, only: %i[index]
  resources :users
  resources :categories, only: %i[index new create show destroy]  do
  resources :expenses , only: %i[index new create destroy]
  end
end
