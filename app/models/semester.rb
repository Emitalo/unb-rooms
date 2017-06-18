class Semester
  include Mongoid::Document

  field :start_date, type: Date
  field :end_date, type: Date
  field :desc, type: String
  field :current, type: Boolean

  def self.current_semester
    find_by current: true
  end
end
