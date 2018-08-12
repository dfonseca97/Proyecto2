class EventController < ApplicationController

  #Controller for the page that receives the geographic coordinates of the client.
  def get_location

  	
  end

  #Stores the received coordinates in the database depending on the current signed in user.
  def store 

    #Creates the event object to be stored on the database.
    respond_to do |format|

  	   latitude = params[:latitude]
  	   longitude = params[:longitude]

  	   @event = Event.new(user: current_user.id, y: latitude, x: longitude)

       #If the event is saved returns to the get location method to get the next coordinates to store.
  	   if @event.save then
                   
                   url = request.original_url.sub("http", "https")
                   url = url.sub("store", "get_location")
  		   format.html{redirect_to url}

  	   else

  		   flash[:notice_booking_failed] = true
  		   redirect_to event_get_location_path

  	    end

    end

  end

  #Creates a date interval for the route to generate.
  def get_date 

  end


  #Creates a Google Maps link with the coordinates of the current logged in user.
  def map

    #Receives the desired date interval to show the route.
    @starting_date = params[:starting][:date_1]
    @ending_date = params[:ending][:date_2]
    @user_events = Event.where(user: current_user.id)
    @result = Array.new

    #Fills the result array with the coordinates to show.
    @user_events.each do |event|

      if((event.created_at.to_time >= @starting_date.to_time) && 
        (event.created_at.to_time <= @ending_date.to_time)) then

        @result << event

      end

    end

    #Creates the Google Maps link to visualize the route.
    @link = "https://www.google.es/maps/dir/"

    @result.each do |coords|
      
      @link.concat("'" + coords.y.to_s + "," + coords.x.to_s + "'" + "/")
    
    end
    
    #Redirects to Google Maps.

  end

end
