class PicturesController < ApplicationController
  before_action :authenticate_user!

  def store
    picture = Picture.new({
      user_id: current_user.id,
      place_id: params[:place_id],
      file: params[:file]
    })

    if picture.save
      render json: picture
    else
      render json: picture.errors
    end
  end
end
