class FestivalController < ApplicationController
  CURRENT_FESTIVAL = '2019'

  def index
    get_festival
  end

  def show
    get_festival(params[:id])
    render :index
  end

  private

  def get_festival(year=CURRENT_FESTIVAL)
    name = "Festival #{year}"
    @events = Event.all.
                    params({
                      'fields.series.sys.contentType.sys.id' => 'series',
                      'fields.series.fields.name[match]' => name
                    }).
                    order('date').
                    load
    @series = Series.find_by(name: name).first()
  end
end
