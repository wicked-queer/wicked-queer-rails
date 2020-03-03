class EventsController < ApplicationController
  def index
    check_preview_api
    @events = Event.all.
                    params({'fields.date[gte]' => DateTime.now.to_s}).
                    order('date').
                    load
  end

  def show
    check_preview_api
    @event = Event.find_by(slug: params[:id]).first()
    @film = @event.film
  end
end
