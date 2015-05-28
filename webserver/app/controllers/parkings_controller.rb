# Parking controller
class ParkingsController < ApplicationController
  def create
    zone_param = zone_find_params
    zone = Zone.custom_find(zone_param[:zone]['name'], zone_param[:zone]['number'])

    if zone
      parking_values = parking_creation_params
      parking_values[:zone] = zone
      parking = Parking.create(parking_values)
      render json: parking.to_json
    else
      render status: 404
    end
  end

  private

  def zone_find_params
    {
      zone: params[:parking].require(:zone).permit(:name, :number)
    }
  end

  def parking_creation_params
    {
      parking_units: params[:parking].require(:parking_units).to_i,
      device_attributes: params[:parking].require(:device).permit(:notification_token, :user_agent),
      car_attributes: params[:parking].require(:car).permit(:license_plate),
      payments_attributes: [params[:parking].require(:payment).permit(:payment_method, :data)]
    }
  end
end
