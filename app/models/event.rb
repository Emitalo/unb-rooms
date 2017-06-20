class Event
  include Mongoid::Document

  belongs_to :semester

  field :name, type: String
  field :responsible, type: String
end

class RepetitiveEvent < Event
  include Mongoid::Document

  field :start_time, type: String
  field :end_time, type: String
  field :days, type: Array
end

class NonRepetitiveEvent < Event
  include Mongoid::Document

  field :start_time, type: DateTime
  field :end_time, type: DateTime
end
