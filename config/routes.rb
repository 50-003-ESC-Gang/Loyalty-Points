Rails.application.routes.draw do
  resources :csv_processings
  root 'pages#home'
  resources :accounts

  resources :loyalty_program_data do
    resources :transactions
  end

  # post '/loyalty_program_data/:loyalty_program_data_id', to: 'loyalty_program_data#confirm'
  match '/loyalty_program_data/:loyalty_program_data_id' => '/loyalty_program_data#confirm', :as => "confirm_url", via: :post 

  resources :transactions

  
  resources :loyalty_programs do
    post :link
  end
  resources :csv_processing

  # view_accrual
  get 'view_accrual' => 'csv_processing#view_accrual'


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users, :controllers => {:registrations => 'users/registrations', :sessions => 'users/sessions'}

  # devise_scope :user do
  #   get 'sign_up', to: 'users/registrations#new'
  # end
  
end
