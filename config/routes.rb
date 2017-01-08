Rails.application.routes.draw do

  get ':controller/:action'
  
  resources :timezones
  resources :countries
  resources :activities
  resources :requests
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
