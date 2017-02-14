Rails.application.routes.draw do

  resources :categories
  resources :timezones
  resources :countries
  resources :activities
  resources :requests
  resources :users

  get 'requests/calendar_events' => 'requests#calendar_events'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
