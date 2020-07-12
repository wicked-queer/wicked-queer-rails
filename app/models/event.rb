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
                       :series

  # coerce_field date: :Date

  def self.find_all
    self.all.load
  end

  def self.find_upcoming
    self.all.
          params({'fields.date[gt]' => (DateTime.now - EVENT_DISPLAY_BUFFER).to_s}).
          limit(200).
          order('date').
          load
  end

  def self.find_by_series series_name
    self.all.
          params({
            'fields.series.sys.contentType.sys.id' => 'series',
            'fields.series.fields.name[match]' => series_name
          }).
          order('date').
          load
  end

  def static_image
    image_url ? image_url : film&.image_url
  end

  def formatted_date
    date&.strftime('%A, %b %-d, %Y  •  %l:%M %p')
  end

  def formatted_cost
    if cost
      if cost == 0
        'FREE'
      elsif cost > 0
        format("$%.2f", cost)
      end
    else
      nil
    end
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
    date < DateTime.now - EVENT_DISPLAY_BUFFER
  end

  def virtual?
    venue.virtual
  end
end
