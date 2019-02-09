class EventsController < ApplicationController
  def index
    @events = Event.all.
                    params({'fields.date[gte]' => DateTime.now}).
                    order('date').
                    load
  end

  def show
    @event = Event.find_by(slug: params[:id]).first()
    @film = @event.film
  end
end
