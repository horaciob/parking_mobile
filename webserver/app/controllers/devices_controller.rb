# Devices controller
class DevicesController < ApplicationController
  def index
    @devs = Device.filter(params.slice(:notification_token, :user_agent))
    render json: @devs, root: false, status: 200
  end

  def show
    @dev = Device.find(params[:id])
    render json: @dev, root: false ,status: 200
  end

  def update
    @dev = Device.find(params[:id])
    @dev = @dev.update_attributes(update_parameters)
    render json: @dev, root: false,status: 200
  end

  def create
    @dev = Device.create(creation_parameters)
    render json: @dev, root: false, status: 201
  end

  private

  def update_parameters
    params.permit(:id, :notification_token, :user_agent)
  end

  def creation_parameters
    params.permit(:car_id, :notification_token, :user_agent)
  end
end
