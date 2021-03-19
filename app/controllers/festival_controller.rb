class FestivalController < ApplicationController
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
    @events = Event.find_by_series(name)
    @series = Series.find_by(name: name).first()
  end
end
