 Rails.application.routes.draw do
  devise_for :users 
    root "projects#index"
    resources :projects
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
      end
  end
