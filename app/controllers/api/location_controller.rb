class Api::LocationController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create


       token = params[:token]
       latitude = params[:latitude]
       longitude = params[:longitude]
       user = params[:user]
       @event = Event.new(user: user, y: latitude, x: longitude)

       if (token == User.find(user).token) and @event.save

         render json: @event, status: :created

         else

         render json: @event.errors, status: :unprocessable_entity

            end

    end

  private

  def location_params

    params.require(:user, :token).permit(:latitude, :longitude, :user, :token)

    end


end
