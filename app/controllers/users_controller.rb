class UsersController < ApplicationController
  def login
    dummy
  end

  def register
    dummy
  end

  private

  def dummy
    render json: {
      name: params[:name] || 'Max Mustermann',
      email: params[:email] || 'max@mustermann.de',
      id: 0
    }
  end
end
