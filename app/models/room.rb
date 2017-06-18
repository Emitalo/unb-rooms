class Room
  include Mongoid::Document

  has_and_belongs_to_many :equipments

  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String
  field :schedule, type: Hash

  def self.get_types
    rooms = self.descendants.map(&:name).sort
    types = {}
    rooms.each do |room|
      case room
        when "RegularClassRoom"
          types[room] = "Sala de Aula"

        when "SmartRoom"
          types[room] = "Sala Inteligente"

        when "RegularConferenceRoom"
          types[room] = "Sala de Conferência comum"

        when "VideoConferenceRoom"
          types[room] = "Sala de Vídeo Conferência"

        when "Lab"
          types[room] = "Laboratório"

      end
    end

    return types
  end
end

class ClassRoom < Room
  include Mongoid::Document
end

class RegularClassRoom < ClassRoom
  include Mongoid::Document
end

class SmartRoom < RegularClassRoom
  include Mongoid::Document
end

class ConferenceRoom < ClassRoom
  include Mongoid::Document
end

class VideoConferenceRoom < ConferenceRoom
  include Mongoid::Document
end

class RegularConferenceRoom < ConferenceRoom
  include Mongoid::Document
end