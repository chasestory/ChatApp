Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :chatrooms do 
    resource :chatroom_users
    resources :messages
  end
  
  resources :direct_messages

  get "/error_403", to: "errors#error_403", as: :error_403
  root to: "chatrooms#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
