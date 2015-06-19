class PlacesController < ApplicationController
  before_action :authenticate_user!

  RANGE = 50 # Anything farther than 50km probably does not make any sense

  def find
    render json: format_places(closest(params[:latitude], params[:longitude]).take(3))
  end

  def show
    place = Place.includes(:pictures).find(params[:id])

    render json: place_attributes(place).merge({ pictures: place.pictures })
  end

  private

  def format_places(places)
    {
      places: places.map do |place|
        place_attributes(place).merge({ picture: place.pictures.first })
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

  def place_attributes(place)
    place.attributes.slice(:longitude, :latitude, :name, :description, :id)
  end
end
