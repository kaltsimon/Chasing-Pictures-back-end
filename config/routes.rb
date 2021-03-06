Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { registrations: 'auth/registrations' }

  get 'places/find', to: 'places#find'
  get 'places/:id', to: 'places#show'
  post '/pictures', to: 'pictures#store'
end
