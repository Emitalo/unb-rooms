class Room
  include Mongoid::Document
  
  has_and_belongs_to_many :equipments
  
  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String

  def self.get_types
    rooms = self.descendants.map(&:name).sort
    print(rooms)
    types = []
    rooms.each do |room|
      type = {}
      case room
        when "RegularClassRoom"
          type[room] = "Sala de Aula"

        when "SmartRoom"
          type[room] = "Sala Inteligente"
        
        when "RegularConferenceRoom"
          type[room] = "Sala de Conferência comum"

        when "VideoConferenceRoom"
          type[room] = "Sala de Vídeo Conferência"

        when "Lab"
          type[room] = "Laboratório"

      end
      if(!type.empty?)
        types.push(type)
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