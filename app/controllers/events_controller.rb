class EventsController < ApplicationController
  def index
  end

  def search
    @events = Event.find_events(params[:name], params[:responsible])
  end
end
