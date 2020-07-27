module EventHelper
  def event_dates(event)
    return unless event
    "#{formatted_date(event.date)} – #{formatted_date(event.safe_end_date)}"
  end

  def event_cost(event)
    return unless event
    return if event.cost.nil?
    event.free? ? 'FREE' : formatted_cost(event.cost)
  end

  def image_with_default(url)
    url ? url : image_path('static.gif')
  end
end
