class EventsController < ApplicationController
  def index
  end

  def search
    @events = Event.find_events(params[:name], params[:responsible])
  end

  def cancel
    event = Event.find params[:id]
    event.room.cancel_event(event)
    event.delete
    flash[:notice] = 'Evento cancelado'
    render :index
  end
end
