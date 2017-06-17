class Lab < Room
  include Mongoid::Document
end

class ChemistryLab < Lab
  include Mongoid::Document
end

class BiologyLab < Lab
  include Mongoid::Document
end

class PhysicsLab < Lab
  include Mongoid::Document
end

class ComputerLab < Lab
  include Mongoid::Document
end
