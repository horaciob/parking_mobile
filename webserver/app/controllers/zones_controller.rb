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
    begin
      @zone = Zone.find(params[:id])
      if @zone.update_attributes(zone_params)
        render json: @zone.to_json, status: 200
      else
        render json: { errors: @zone.errors.full_messages }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Could not found #{params[:id]} zone" }, status: 404
    end
  end

  private

  def zone_params
    params.permit(:name, :number,:unit_price, :unit_time)
  end
end
