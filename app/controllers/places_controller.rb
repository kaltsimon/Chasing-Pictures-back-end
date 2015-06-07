class PlacesController < ApplicationController
  RANGE = 50 # Anything farther than 50km probably does not make any sense

  def find
    render json: closest(params[:latitude], params[:longitude]).take(3)
  end

  private

  def closest(lat, lon)
    Place.near(
      [lat, lon],
      RANGE,
      units: :km
    )
  end
end
