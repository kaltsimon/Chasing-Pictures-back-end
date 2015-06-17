class PlacesController < ApplicationController
  before_action :authenticate_user!

  RANGE = 50 # Anything farther than 50km probably does not make any sense

  def find
    render json: format_places(closest(params[:latitude], params[:longitude]).take(3))
  end

  private

  def format_places(places)
    {
      places: places.map do |place|
      {
        name: place.name,
        id: place.id,
        latitude: place.latitude,
        longitude: place.longitude,
        description: place.description,
        picture: place.pictures.first
      }
      end
    }
  end

  def closest(lat, lon)
    Place.near(
      [lat, lon],
      RANGE,
      units: :km
    )
  end
end
