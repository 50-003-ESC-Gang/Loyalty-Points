Rails.application.routes.draw do
  resources :accounts
  resources :loyalty_program_data
  resources :transactions
  root 'pages#home'
  resources :loyalty_programs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
