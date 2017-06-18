class HomeController < ApplicationController
  def index
    @room_types = Room.types
    @days_of_week = %w[Segunda Terça Quarta Quinta Sexta]
  end
end
