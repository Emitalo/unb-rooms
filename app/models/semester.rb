class Semester
  include Mongoid::Document

  field :year, type: Integer
  field :period, type: Integer
end
