class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    # Get a list of all available drivers
    @drivers = Driver.all

    # Get A list of all available actions
    @metrics = Metric.group('metric_name')

    @no_data = FALSE
    if @drivers.size == 0 or @metrics.size == 0
      @no_data = TRUE
    end
  end
end
