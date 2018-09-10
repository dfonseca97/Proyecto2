class MapController < ApplicationController
  include Secured

  def index
  end
  
  def show
    @starting_date = params[:starting][:date_1]
    @ending_date = params[:ending][:date_2]
    @user_events = Position.where(user: current_user.id)
    @results = Array.new

    #Fills the result array with the coordinates to show.
    @user_events.each do |event|

      if((event.created_at.to_time >= @starting_date.to_time) && 
        (event.created_at.to_time <= @ending_date.to_time)) then

        @results << event

      end

    end
    @lat = 0.0
    @lon = 0.0
    if @results.count > 0 
      @results.each do |location|
        @lat += location[:latitud]
        @lon += location[:longitud]
      end
      @lat /= @results.count
      @lon /= @results.count
    end
  end
end
