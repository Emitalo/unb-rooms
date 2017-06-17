class Room
  include Mongoid::Document
  
  has_and_belongs_to_many :equipments
  
  field :capacity, type: Integer
  field :nickname, type: String
  field :identifier, type: String
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