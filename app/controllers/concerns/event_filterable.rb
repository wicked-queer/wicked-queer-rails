module EventFilterable
  extend ActiveSupport::Concern

  def filters
    [TYPE, VENUE]
  end

  def filter_events(events)
    return [] unless events

    filters.inject(events) do |filtered_events, filter|
      options = params[filter[:name]]
      return filtered_events if options.nil? || options.empty?

      filtered_events.select{ |event| filter[:filter].call(event, options) }
    end
  end

  private

  # The filters ///////////////////////////////////////////////////////////////

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

  def self.filter_by_type(event, types)
    types.include? event.event_type
  end

  def self.filter_by_venue(event, venues)
    venues.include? event.venue.id
  end

  # filter options ////////////////////////////////////////////////////////////

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
