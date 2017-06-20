class RoomsController < ApplicationController
  def index
    @available_rooms = Room.find_availables(params)
  end

  def show
    @room = Room.find params[:id]
  end

  def allocate_repetitive
    @room = Room.find params[:room_id]
    @days_of_week = {1 => 'Segunda', 2 => 'Terça', 3 => 'Quarta', 4 => 'Quinta', 5 => 'Sexta'}
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

    event = RepetitiveEvent.new event_params
    semester = Semester.current_semester

    (semester.start_date..semester.end_date).each do |date|
      if days.include?(date.cwday.to_s)
        (start_time[0].to_i..end_time[0].to_i).each do |hour|
          datetime = DateTime.new(date.year, date.month, date.day, hour)
          room.schedule = {} if room.schedule.nil?
          room.schedule[datetime.to_time.to_i] = event.id.to_s unless room.schedule.has_key?(datetime.to_time.to_i)
        end
      end
    end
    room.save!

    render :index
  end

  def allocate_non_repetitive_event
    room = Room.find params[:room_id]
    event = NonRepetitiveEvent.new non_repetitive_event_params
  end

  def repetitive_event_params
    params.permit(
      :name, :responsible,
      :days, :start_time, :end_time
    )
  end

  def non_repetitive_event_params
    params.permit(
      :name, :responsible,
      :days, :start_time, :end_time
    )
  end
end
