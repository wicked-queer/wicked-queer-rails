module EventFilterable
  extend ActiveSupport::Concern

  def filters
    [SPECIAL_EVENT, TYPE, VENUE]
  end

  def filter_events(events)
    return [] unless events

    filters.inject(events) do |filtered_events, filter|
      options = params[filter[:name]]
      if options.nil? || options.empty?
        filtered_events
      else
        filtered_events.select{ |event| filter[:filter].call(event, options) }
      end
    end
  end

  private

  # The filters ///////////////////////////////////////////////////////////////

  # JURIED = {
  #   name: 'juried',
  #   label: 'Juried',
  #   filter: proc { |event, juried| filter_by_juried(event, juried) },
  #   options: proc { |events| juried_filter_options(events) }
  # }

  SPECIAL_EVENT = {
    name: 'special_event',
    label: 'Special Event',
    filter: proc { |event, specials| filter_by_special_event(event, specials) },
    options: proc { |events| special_event_filter_options(events) }
  }

  TYPE = {
    name: 'type',
    label: 'Type',
    filter: proc { |event, types| filter_by_type(event, types) },
    options: proc { |events| type_filter_options(events) }
  }

  VENUE = {
    name: 'venue',
    label: 'Venue',
    filter: proc { |event, venues| filter_by_venue(event, venues) },
    options: proc { |events| venue_filter_options(events) }
  }

  # filter_by methods /////////////////////////////////////////////////////////

  # def self.filter_by_juried(event, juried)
  #   juried.include? event.in_competition
  # end
  
  def self.filter_by_special_event(event, specials)
    specials.include? event.special_event
  end

  def self.filter_by_type(event, types)
    types.include? event.event_type
  end

  def self.filter_by_venue(event, venues)
    venues.include? event.venue.id
  end

  # filter options ////////////////////////////////////////////////////////////

  # def self.juried_filter_options(events)
  #   [true, false].each do |juried|
  #     {
  #       value: juried,
  #       label: (juried ? 'In Competition' : 'Not in competition'),
  #       selected: false,
  #       disabled: false
  #     }
  #   end
  # end

  def self.special_event_filter_options(events)
    events.map(&:special_event).uniq.compact.map do |special_event|
      {
        value: special_event,
        label: special_event.humanize,
        selected: false,
        disabled: false
      }
    end
  end

  def self.type_filter_options(events)
    events.map(&:event_type).uniq.compact.map do |type|
      {
        value: type,
        label: type.humanize,
        selected: false,
        disabled: false
      }
    end
  end

  def self.venue_filter_options(events)
    events.map(&:venue).uniq.compact.map do |venue| 
      {
        value: venue.id,
        label: venue.name,
        selected: false,
        disabled: false
      }
    end
  end
end
