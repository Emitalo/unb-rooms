class RoomsController < ApplicationController
  def index
  	@room_type = params[:room_type_class]
  end

  def show
    @room = Room.find params[:id]
  end

  def allocate_repetitive
    @room = Room.find params[:room_id]
  end

  def allocate_non_repetitive
    @room = Room.find params[:room_id]
  end

  def allocate
    byebug
  end
end
