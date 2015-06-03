# Zone handler
class ZonesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @zone = Zone.all
    render json: @zone.to_json
  end

  def create
    @zone = Zone.new(zone_params)
    if @zone.save
      render json: @zone, status: :created
    else
      render json: { errors: @zone.errors.full_messages }, status: 400
    end
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone.update_attributes(zone_params)
      render json: @zone.to_json, status: 200
    else
      render json: { errors: @zone.errors.full_messages }
    end
  end

  def show
    zone = Zone.find(params[:id])
    render json: zone, status: 200
  end

  private

  def zone_params
    params.permit(:name, :number, :unit_price, :unit_time)
  end
end
