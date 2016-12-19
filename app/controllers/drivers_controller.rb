class DriversController < ApplicationController
  def index
    @drivers = Driver.all
    render json: @drivers.as_json
  end
end
