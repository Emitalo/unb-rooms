class Room
  include Mongoid::Document

  has_and_belongs_to_many :equipments
  has_many :events

  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String
  field :schedule, type: Hash

  REPETITIVE_ID = "2"

  def self.types
    Lab
    types = {}
    descendants.each do |type|
      types[type.name] = type::NAME if type.const_defined? 'NAME'
    end
    types
  end

  def self.find_availables(params)
    type = params[:room_type_class].constantize
    if(params[:capacity] != "" && params[:capacity] != nil)
      available_rooms = type.where(:capacity.gte => params[:capacity])
    else
      available_rooms = type.all()
    end

    start_time = params[:start_time].split(':')
    end_time = params[:end_time].split(':')
    if(params[:event_type_id] == self::REPETITIVE_ID)
      available_rooms = self.get_available_room_for_repetitive_event(params[:days_of_week], start_time, \
                        end_time, available_rooms)
    else
      available_rooms = self.get_available_room_for_not_repetitive_event(params[:days], start_time, end_time, available_rooms)
    end

    available_rooms
  end

  def self.get_available_room_for_repetitive_event(days_of_week, initial_hour, end_hour, available_rooms)
    rooms = []
    current_semester = Semester.current_semester
    hours = self.get_hours_range(initial_hour, end_hour)
    available_rooms.each do |available_room|
      can_add_room = true
      schedule = available_room.schedule
      if(schedule == nil)
        rooms.push(available_room)
      else
        schedule_for_semester = schedule[current_semester.id.to_s]
        if(schedule_for_semester != nil)
          schedule_for_semester.each do |event_datetime, event_id|
            date = Time.at(event_datetime.to_i).utc.to_datetime
            hour_on_date = date.strftime("%H")
            if(hours.include?(hour_on_date) && days_of_week.include?(date.cwday.to_s))
              can_add_room = false
              break
            end
          end

          if(can_add_room)
            rooms.push(available_room)
          end
        end
      end
    end
    rooms
  end

  def self.get_available_room_for_not_repetitive_event(days, initial_hour, end_hour, available_rooms)
    rooms = []
    current_semester = Semester.current_semester
    hours = self.get_hours_range(initial_hour, end_hour)
    available_rooms.each do |available_room|
      can_add_room = true
      schedule = available_room.schedule
      if(schedule == nil)
        rooms.push(available_room)
      else
        schedule_for_semester = schedule[current_semester.id.to_s]
        if(schedule_for_semester != nil)
          schedule_for_semester.each do |event_datetime, event_id|
            date = Time.at(event_datetime.to_i).utc.to_datetime
            hour_on_date = date.strftime("%H")
            date_to_test = date.strftime("%d/%m/%Y")
            if(hours.include?(hour_on_date) && days.include?(date_to_test))
              can_add_room = false
              break
            end
          end

          if(can_add_room)
            rooms.push(available_room)
          end
        end
      end
    end
    rooms
  end

  def self.get_hours_range(initial_hour, end_hour)
    hours = []
    (initial_hour[0].to_i..end_hour[0].to_i).each do |hour|
      hour_to_add = hour.to_s.size == 1 ? "0" + hour.to_s : hour.to_s
      hours.push(hour_to_add)
    end

    hours
  end

  def allocate(event)
    return unless respond_to?(:can_allocate?) && can_allocate?(event)
  end

  def can_allocate?(_event)
    true
  end

  def cancel_event(event, semester: nil)
    semester = semester.nil? ? Semester.current_semester : semester
    schedule[semester.id.to_s].each do |key, registered_event|
      schedule[semester.id.to_s].delete(key) if registered_event == event.id.to_s
    end
    save!
  end
end

class ClassRoom < Room
  include Mongoid::Document
end

class RegularClassRoom < ClassRoom
  include Mongoid::Document

  NAME = 'Sala de aula'.freeze
end

class SmartRoom < ClassRoom
  include Mongoid::Document

  NAME = 'Sala Inteligente'.freeze
end

class ConferenceRoom < ClassRoom
  include Mongoid::Document
end

class VideoConferenceRoom < ConferenceRoom
  include Mongoid::Document

  NAME = 'Sala de Vídeo Conferência'.freeze
end

class RegularConferenceRoom < ConferenceRoom
  include Mongoid::Document

  NAME = 'Sala de Conferência comum'.freeze
end