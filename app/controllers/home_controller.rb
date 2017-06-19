class HomeController < ApplicationController
  def index
    @room_types = Room.types
    @days_of_week = {1 => 'Segunda', 2 => 'Terça', 3 => 'Quarta', 4 => 'Quinta', 5 => 'Sexta'}
  end
end
