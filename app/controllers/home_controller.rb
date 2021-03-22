class HomeController < ApplicationController
  include EventSortable
  include EventFilterable
  
  def index
    check_preview_api
    @homePage = Home.find('3nFzh4wcHYKa28Sui08msi')
    @all_events = Event.upcoming
    @events = filter_events(@all_events)
    @events = sort_events(@events)

    @sort_options = sort_options
    @filters = filters
  end
end
