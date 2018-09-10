class Api::LocationController < ApplicationController
  #skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def create
    latitud = params[:lat]
    longitud = params[:lon]
    token = params[:token]
    user = params[:user]
    @position = Position.new(user: user,latitud: latitud, longitud: longitud)
    if (token == User.find(user).token) and @position.save
      render json: @position, status: :created
    else
      render json: @position.errors, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:user, :token).permit(:lat, :lon)
  end

end