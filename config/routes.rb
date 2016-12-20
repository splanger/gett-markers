Rails.application.routes.draw do
  # Fetch a list of all drivers in JSON format
  get '/drivers', to: 'drivers#index'

  # Fetch a list of a driver's metrics
  # Note:
  #   Since there's a lot of metrics, it is obligatory
  #   to pass "metric_name" as a query param. Otherwise,
  #   a list of all available metrics names of a driver
  #   will be returned.
  get '/drivers/:driver_id/metrics', to: 'metrics#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Application's root goes straight to "application_controller#index"
end
