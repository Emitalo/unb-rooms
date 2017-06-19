class Room
  include Mongoid::Document

  has_and_belongs_to_many :equipments

  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String
  field :schedule, type: Hash

  REPETITIVE_ID = "2"

  def self.types
    types = {}
    descendants.each do |type|
      types[type.name] = type::NAME if type.const_defined? 'NAME'
    end
    types
  end

  def self.find_availables(params)
    type = params[:room_type_class].constantize
    available_rooms = type.where(:capacity.gte => params[:capacity])
    if(params[:event_type_id] == self::REPETITIVE_ID)
      self.get_available_room_for_repetitive_event(params[:days_of_week], params[:hour], available_rooms)
    else
      self.get_available_room_for_not_repetitive_event(params[:initial_date], params[:end_date], params[:hour], available_rooms)
    end

    available_rooms
  end

  def self.get_available_room_for_repetitive_event(days_of_week, hour, available_rooms)
    rooms = []
    current_semester = Semester.current_semester
    days_on_dates = []
    available_rooms.each do |available_room|
      schedule = available_room.schedule
      if(schedule == nil)
        rooms.push(available_room)
      else
        schedule_for_semester = schedule[current_semester.id.to_s]
        can_add_room = true
        schedule_for_semester.each do |event_datetime, event_id|
          date = Time.at(event_datetime.to_i).to_datetime
          hour_on_date = date.strftime("%H") + ":" + date.strftime("%M")
          if(hour_on_date == hour && days_of_week.include?(date.cwday))
            can_add_room = false
          end
        end

        if(can_add_room)
          rooms.push(available_room)
        end
      end
    end
    rooms
  end

  def self.get_available_room_for_not_repetitive_event(initial_date, end_date, hour, available_rooms)
    return nil
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