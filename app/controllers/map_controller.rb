require 'tzinfo'

class MapController < ApplicationController
  include Secured

  def index
  end
  
  def show
    tz = TZInfo::Timezone.get(current_user.timezone)
    @starting_date = tz.local_to_utc(params[:starting][:date_1].to_time)
    @ending_date = tz.local_to_utc(params[:ending][:date_2].to_time)
    @user_events = Position.where(user: current_user.id)
    @results = Array.new

    #Fills the result array with the coordinates to show.
    @user_events.each do |event|

      if((event.created_at.to_time >= @starting_date) && 
        (event.created_at.to_time <= @ending_date)) then

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
