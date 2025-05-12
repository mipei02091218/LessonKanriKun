Rails.application.routes.draw do
  get 'homes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "homes#index"
  devise_for :users

  resources :lessons do
    member do
      get :edit
      delete :destroy
    end
    resources :absences, only: [:create, :destroy]
  end

  resources :absences, only: [:new, :create]
  resources :notices, only: [:new, :create, :edit, :update, :destroy,]
  
  resources :messages, only: [:index, :show, :new, :create] do
    member do
      get :reply
      post :create_reply
    end
  end

end
