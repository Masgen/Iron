Irond::Application.routes.draw do
  root to: "home_pages#show"

  match "/login", to: "sessions#create", as: "login"
  match "/logout", to: "sessions#destroy", as: "logout"
  
  resources :products do
    collection do
      post :search
      get :search
      post :fill
    end
  end
  resource :subscriptions
  resource :home_page do
    get :administrate
    post :add_featured
    post :remove_featured
    collection do
      get :manage
    end
  end
  resource :sessions
  resource :user
end
