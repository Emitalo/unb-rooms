class HomeController < ApplicationController
  
  def index
  	@room = Room.new
  	@room_types = Room.get_types
  end


end
