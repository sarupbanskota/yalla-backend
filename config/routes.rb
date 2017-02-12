Rails.application.routes.draw do

  get 'requests/calendar_events' => 'requests#calendar_events'

  resources :timezones
  resources :countries
  resources :activities
  resources :requests
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
