Rails.application.routes.draw do
  resources :loyalty_program_data
  resources :transactions
  root 'pages#home'
  devise_for :users
  resources :loyalty_programs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
