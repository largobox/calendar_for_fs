Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/users', to: redirect('/users/sign_up')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "calendar_events#index"

  resources :calendar_events do
	  collection do
	    get 'user_events/:user_id', action: :user_events, as: :user_events
	  end
  end
end
