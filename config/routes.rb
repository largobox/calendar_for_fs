Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/users', to: redirect('/users/sign_up')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "events#index"

  resources :events
end
