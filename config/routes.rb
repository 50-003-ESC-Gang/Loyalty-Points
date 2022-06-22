Rails.application.routes.draw do
  root 'pages#home'
  resources :loyalty_programs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users, :controllers => {:registrations => 'users/registrations', :sessions => 'users/sessions'}

  # devise_scope :user do
  #   get 'sign_up', to: 'users/registrations#new'
  # end
  
end
