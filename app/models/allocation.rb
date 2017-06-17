class Allocation
  include Mongoid::Document

  belongs_to :room
  belongs_to :event
end
