class HomeController < ApplicationController

   def index  
      @url = request.original_url.sub("http", "https")
      @url = @url.concat("event/get_location")
   end

end
