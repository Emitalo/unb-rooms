class RoomsController < ApplicationController
  def index
    @available_rooms = Room.find_availables(params)
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
