class EventsController < ApplicationController
  def index
    @events = Event.all.load
  end

  def show
  end
end
