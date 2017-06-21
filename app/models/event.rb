class Event
  include Mongoid::Document

  belongs_to :semester
  belongs_to :room

  field :name, type: String
  field :responsible, type: String

  DAYS_OF_WEEK = {
    1 => 'Segunda', 2 => 'Terça',
    3 => 'Quarta', 4 => 'Quinta',
    5 => 'Sexta'
  }.freeze

  def print_days_of_week
    return unless respond_to? :days
    days_of_week = ''
    days.each do |day|
      days_of_week << DAYS_OF_WEEK[day.to_i] << ','
    end unless days.nil?
    days_of_week
  end
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
