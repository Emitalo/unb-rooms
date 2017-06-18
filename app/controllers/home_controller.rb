class HomeController < ApplicationController
  
  def index
  	@room_types = Room.get_types
  	@days_of_week = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"];
  end


end
