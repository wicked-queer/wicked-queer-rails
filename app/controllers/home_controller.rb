class HomeController < ApplicationController
  def index
    check_preview_api
    @homePage = HomePage.find('3nFzh4wcHYKa28Sui08msi')
    @events = Event.all.
                    params({'fields.date[gte]' => (DateTime.now - 3.hours).to_s}).
                    limit(11).
                    order('date').
                    load
  end
end
