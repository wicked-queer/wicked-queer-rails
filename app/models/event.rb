class Event < ContentfulModel::Base
  # How long to keep events up after the start time.
  EVENT_DISPLAY_BUFFER = 21.hours

  self.content_type_id = 'event'

  has_one :series
  has_one :venue
  has_one :film, class_name: 'Film'
  has_many :additional_films, class_name: 'Film', inverse_of: :event
  has_many :presenters, class_name: 'Presenter', inverse_of: :event

  return_nil_for_empty :title, :slug, :date, :cost, :url, :description, :guest,
                       :image, :presenter, :additional_films, :film, :venue,
                       :series, :end_date, :event_type, :promoted, :special_event

  # coerce_field date: :Date

  def self.find_all
    self.all.load
  end

  def self.upcoming
    self.all.
          params({'fields.endDate[gt]' => DateTime.now.to_s}).
          limit(200).
          load
  end

  def self.find_by_series_name series_name
    self.all.
          params({
            'fields.series.sys.contentType.sys.id' => 'series',
            'fields.series.fields.name[match]' => series_name
          }).
          order('date').
          load
  end

  def self.find_by_series_slug series_slug
    self.all.
          params({
            'fields.series.sys.contentType.sys.id' => 'series',
            'fields.series.fields.slug[match]' => series_slug
          }).
          order('date').
          load
  end

  def self.find_by_multiple(series: nil, venue: nil, type: nil, upcoming: false, sort: 'default')
    params = {}
    if series
      params.merge!({
        'fields.series.sys.contentType.sys.id' => 'series',
        'fields.series.fields.slug[match]' => series
      })
    end

    if venue
      params.merge!({
        'fields.venue.sys.contentType.sys.id' => 'venue',
        'fields.venue.fields.id[in]' => venue
      })
    end

    if type
      params.merge!({
        'fields.eventType[in]' => type
      })
    end

    if upcoming
      params.merge!({
        'fields.endDate[gt]' => DateTime.now.to_s
      })
    end

    order = case sort
            when 'date'
              ['fields.date', 'fields.title']
            when 'title'
              ['fields.title', 'fields.date']
            else
              ['fields.promoted', 'fields.date', 'fields.title']
            end

    params.merge!({order: order})

    self.all.params(params).load
  end

  def static_image
    image_url ? image_url : film&.image_url
  end

  def free?
    cost == 0
  end

  def full_description
    full_description = ''
    full_description += film.description if film && film.description
    full_description += description if description
    full_description
  end

  def image_url
    image&.file&.url || film&.image_url
  end

  def is_past?
    (safe_end_date) < DateTime.now
  end

  def virtual?
    venue.virtual
  end

  def safe_end_date
    end_date || date + 3.hours
  end

  def attendance_mode
    virtual? ? 'https://schema.org/OnlineEventAttendanceMode' :
              'https://schema.org/OfflineEventAttendanceMode'
  end

  def to_hash
    {
      additional_films: additional_films&.map(&:to_hash),
      cost: cost,
      end_date: safe_end_date,
      event_type: event_type,
      free: free?,
      film: film&.to_hash,
      guest: guest,
      is_past: is_past?,
      promoted: promoted,
      series: series&.to_hash,
      slug: slug,
      start_date: date,
      special_event: special_event,
      title: title,
      url: url,
      venue: venue&.to_hash,
      virtual: virtual?,
    }
  end

  def to_json
    to_hash.to_json
  end

  def to_schema
    {
      '@context' => 'https://schema.org',
      '@type' => 'ScreeningEvent',
      'name' => title,
      'startDate' => date,
      'endDate' => safe_end_date,
      'eventAttendanceMode' => attendance_mode,
      'description' => full_description,
      'image' => [static_image],
      'organizer' => {
        '@type' => 'Organization',
        'name' => "Wicked Queer, Boston's LGBTQ+ Film Festival",
        'url' => 'https://www.wickedqueer.org'
      },
      'offers': {
        '@type': 'Offer',
        'url': url,
        'price': cost,
        'priceCurrency': 'USD',
        'availability': 'https://schema.org/InStock',
        'validFrom': date
      }
    }
  end
end
