class Lab < Room
  include Mongoid::Document
end

class ChemistryLab < Lab
  include Mongoid::Document

  NAME = 'Laboratório de química'.freeze
end

class BiologyLab < Lab
  include Mongoid::Document

  NAME = 'Laboratório de biologia'.freeze
end

class PhysicsLab < Lab
  include Mongoid::Document

  NAME = 'Laboratório de física'.freeze
end

class ComputerLab < Lab
  include Mongoid::Document

  NAME = 'Laboratório de computação'.freeze

  field :for_students, type: Boolean
end
