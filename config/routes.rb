Rails.application.routes.draw do
  root 'pages#home'
  resources :accounts

  resources :loyalty_program_data do
    resources :transactions
  end
  
  resources :loyalty_programs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
