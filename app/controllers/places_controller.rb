class PlacesController < ApplicationController
  before_action :authenticate_user!

  RANGE = 50 # Anything farther than 50km probably does not make any sense

  def find
    render json: format_places(closest(params[:latitude], params[:longitude]).take(3))
  end

  def show
    place = Place.includes(:pictures).find(params[:id])

    render json: {
      places: [
        place_with_pictures(place, place.pictures)
      ]
    }
  end

  private

  def format_places(places)
    {
      places: places.map do |place|
        place_with_pictures(place, [place.pictures.first])
      end
    }
  end

  def place_with_pictures(place, pictures)
    place.attributes.merge pictures: add_url_to_pictures(pictures)
  end

  def add_url_to_pictures(pictures)
    pictures.map do |picture|
      picture.url ||= URI.join(request.url, picture.file.url(:medium))
      picture
    end
  end

  def closest(lat, lon)
    Place.near(
      [lat, lon],
      RANGE,
      units: :km
    )
  end
end
