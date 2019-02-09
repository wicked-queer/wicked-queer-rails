class EventsController < ApplicationController
  def index
    @events = Event.all.
                    params({'fields.date[gte]' => DateTime.now}).
                    order('date').
                    load
  end

  def show
  end
end
