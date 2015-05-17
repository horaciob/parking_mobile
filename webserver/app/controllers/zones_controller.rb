class ZonesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    Zone.all
  end

  def create
    @zone = Zone.new(zone_params)
    if @zone.save
      render json: @zone
    else
      render json: { errors: @zone.errors.full_messages }
    end

  end

  private
  def zone_params
    params.permit(:zone, :zone_number, :unit_price, :unit_time)
  end


end
