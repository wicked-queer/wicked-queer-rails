class HomeController < ApplicationController
  def index
    check_preview_api
    @homePage = Home.find('3nFzh4wcHYKa28Sui08msi')
    @events = Event.upcoming
  end
end
