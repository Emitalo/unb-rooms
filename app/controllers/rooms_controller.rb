class RoomsController < ApplicationController
  
  def index
  	@room_type = params[:room_type_class]
  end


end