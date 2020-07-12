class EventsController < ApplicationController
  def index
    check_preview_api
    @events = Event.find_upcoming
  end

  def show
    check_preview_api
    @event = Event.find_by(slug: params[:id]).first()
    @film = @event.film
  end
end
