class Room
  include Mongoid::Document

  has_and_belongs_to_many :equipments

  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String
  field :schedule, type: Hash

  def self.types
    types = {}
    descendants.each do |type|
      types[type.name] = type::NAME if type.const_defined? 'NAME'
    end
    types
  end
end

class ClassRoom < Room
  include Mongoid::Document
end

class RegularClassRoom < ClassRoom
  include Mongoid::Document

  NAME = 'Sala de aula'.freeze
end

class SmartRoom < RegularClassRoom
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