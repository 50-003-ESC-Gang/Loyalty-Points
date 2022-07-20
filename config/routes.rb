Rails.application.routes.draw do
  resources :csv_processings
  root 'pages#home'
  resources :accounts

  resources :loyalty_program_data do
    resources :transactions
  end


  resources :transactions

  resources :csv_processing

  # view_accrual
  get 'view_accrual' => 'csv_processing#view_accrual'


  
  resources :loyalty_programs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users, :controllers => {:registrations => 'users/registrations', :sessions => 'users/sessions'}

  # devise_scope :user do
  #   get 'sign_up', to: 'users/registrations#new'
  # end
  
end
