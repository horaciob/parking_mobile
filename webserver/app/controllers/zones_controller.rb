# Zone handler
class ZonesController < ApplicationController
  def index
    @zones = Zone.filter(params.slice(:by_number, :by_name))
    render json: @zones.to_json
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
    @zone = nil
    if params['id'].to_i != 0
      @zone = Zone.find(params['id'])
    else
      name,number = params['id'].split("-")
      @zone = Zone.custom_find(name,number)
    end
    unless @zone.blank?
      render json: @zone, status: 200
    else
      render json: {error:'not found'}, status: 404
    end
  end

  private

  def zone_params
    params.permit(:name, :number, :unit_price, :unit_time)
  end
end
