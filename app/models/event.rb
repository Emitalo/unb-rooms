class Event
  include Mongoid::Document

  belongs_to :semester
  belongs_to :room

  field :name, type: String
  field :responsible, type: String
  field :start_time, type: String
  field :end_time, type: String
  field :days, type: Array

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

  def self.find_events(name, responsible)
    events = where({})
    events = events.where(name: /#{name}/i) unless name.to_s.empty?
    events = events.where(responsible: /#{responsible}/i) unless responsible.to_s.empty?
    events
  end
  
end

class RepetitiveEvent < Event
  include Mongoid::Document

end

class NonRepetitiveEvent < Event
  include Mongoid::Document
end
