class SeriesController < ApplicationController
  include EventSortable
  include EventFilterable

  def show
    @series = Series.find_by(slug: params[:id]).first()
    @all_events = Event.find_by_multiple(series: params[:id], upcoming: true)
    @events = filter_events(@all_events)
    @events = sort_events(@events)

    @sort_options = sort_options
    @filters = filters
  end
end
