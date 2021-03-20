module EventSortable
  extend ActiveSupport::Concern

  def sort_options
    [DEFAULT, DATE, TITLE]
  end

  def sort_events(events)
    return [] unless events

    sort = sort_options.find{ |sort_option| sort_option[:value] === params[:sort] }
    sort ||= DEFAULT
    sort[:sort].call(events)
  end

  private

  # The sort options

  DATE = {
    value: 'date',
    label: 'Date',
    sort: proc { |events| sort_by_date(events) }
  }

  TITLE = {
    value: 'title',
    label: 'Title',
    sort: proc { |events| sort_by_title(events) }
  }

  DEFAULT = {
    value: 'default',
    label: 'Default',
    sort: proc { |events| sort_by_standard(events) }
  }

  # The sort_by methods

  def self.sort_by_date(events)
    events.sort_by{ |event| [event.date, event.title] }
  end

  def self.sort_by_title(events)
    events.sort_by{ |event| [event.title, event.date] }
  end

  def self.sort_by_standard(events)
    events.sort_by{ |event| [event.promoted ? 0 : 1, event.date, event.title] }
  end
end
