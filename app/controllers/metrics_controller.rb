class MetricsController < ApplicationController
  def index
    if params[:metric_name] != nil
      # Fetch a list of a specific metrics by metric_name
      @driver = Driver.find(params[:driver_id])
      result = @driver.metrics.where('metric_name = ?', params[:metric_name])
      render json: result.as_json
    else
      # Just fetch a list of available metrics for a driver
      @driver = Driver.find(params[:driver_id])
      result = @driver.metrics.group('metric_name')
      render json: result.as_json
    end
  end
end
