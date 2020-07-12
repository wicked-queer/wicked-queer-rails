class HomeController < ApplicationController
  def index
    check_preview_api
    @homePage = HomePage.find('3nFzh4wcHYKa28Sui08msi')
    @events = Event.find_upcoming
  end
end
