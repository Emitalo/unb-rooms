class RoomsController < ApplicationController
  def index
    @available_rooms = Room.find_availables(params)
  end

  def show
    @room = Room.find params[:id]
  end

  def allocate_repetitive
    @room = Room.find params[:room_id]
    @days_of_week = Event::DAYS_OF_WEEK
  end

  def allocate_non_repetitive
    @room = Room.find params[:room_id]
  end

  def allocate_repetitive_event
    Event
    room = Room.find params[:room_id]

    event_params = repetitive_event_params
    start_time = event_params[:start_time].split(':')
    end_time = event_params[:end_time].split(':')
    days = params[:days]

    semester = Semester.current_semester
    event = RepetitiveEvent.new event_params
    event.semester = semester
    event.room = room
    event.save!

    (semester.start_date..semester.end_date).each do |date|
      if days.include?(date.cwday.to_s)
        (start_time[0].to_i..(end_time[0].to_i - 1)).each do |hour|
          datetime = DateTime.new(date.year, date.month, date.day, hour)
          room.schedule = {} if room.schedule.nil?
          room.schedule[semester.id.to_s] = {} if room.schedule[semester.id.to_s].nil?
          room.schedule[semester.id.to_s][datetime.to_time.to_i] = event.id.to_s unless room.schedule.has_key?(datetime.to_time.to_i)
        end
      end
    end
    room.save!

    Allocation.create! room: room, event: event

    flash[:notice] = "Evento alocado para sala #{room.identifier}!"
    render :index
  end

  def allocate_non_repetitive_event
    room = Room.find params[:room_id]
    event = NonRepetitiveEvent.new non_repetitive_event_params
  end

  def repetitive_event_params
    params.permit(:name, :responsible, :start_time, :end_time, days: [])
  end

  def non_repetitive_event_params
    params.permit(
      :name, :responsible,
      :days, :start_time, :end_time
    )
  end
end
