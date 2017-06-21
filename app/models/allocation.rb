class Allocation
  include Mongoid::Document

  belongs_to :room
  belongs_to :event

  field :date, type: DateTime, default: -> { DateTime.now }
end
