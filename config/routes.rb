Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips, only: [:index, :show]
  resources :trails, only: [:show]

  delete "/trail_trips/:trip_id/:trail_id", to: "trail_trips#destroy"
end
