class Semester
  include Mongoid::Document

  field :start_date, type: Date
  field :end_date, type: Date
  field :desc, type: String
end
