class HomeController < ApplicationController
  def index
    @homePage = HomePage.find('3nFzh4wcHYKa28Sui08msi')
    @events = Event.all.
                    params({'fields.date[gte]' => DateTime.now}).
                    limit(11).
                    order('date').
                    load
    @home = true
  end
end
