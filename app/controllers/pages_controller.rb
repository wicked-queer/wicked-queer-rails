class PagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:id]).first()
  end
end
