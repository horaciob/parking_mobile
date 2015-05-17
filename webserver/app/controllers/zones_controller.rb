class ZonesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @zone = Zone.all
  end

  def create
    @zone = Zone.new(zone_params)
    if @zone.save
      render json: @zone
    else
      render json: { errors: @zone.errors.full_messages }
    end
  end

  def update
    @zone = Zone.find(params[:id])
    if @zone
      if @zone.update_attributes(zone_params)
        render json: @zone
      else
        render json: { errors: @zone.errors.full_messages }
      end
    else
      render json: {errors: "Could not found #{params[:id]} zone"}
    end
  end



  private
  def zone_params
    params.permit(:zone, :zone_number, :unit_price, :unit_time)
  end


end
