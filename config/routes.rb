Rails.application.routes.draw do
  get '/drivers', to: 'drivers#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Application's root goes straight to "application_controller#index"
end
