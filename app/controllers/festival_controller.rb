class FestivalController < ApplicationController
  include EventSortable
  include EventFilterable

  CURRENT_FESTIVAL = '2021'

  def index
    get_festival
  end

  def show
    get_festival(params[:id])
    render :index
  end

  private

  def get_festival(year=CURRENT_FESTIVAL)
    check_preview_api
    name = "Festival #{year}"
    @series = Series.find_by(name: name).first()
    @all_events = Event.find_by_series_name name
    @events = filter_events(@all_events)
    @events = sort_events(@events)

    @sort_options = sort_options
    @filters = filters
  end
end
