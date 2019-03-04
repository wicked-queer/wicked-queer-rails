class PagesController < ApplicationController
  def show
    check_preview_api
    @page = Page.find_by(slug: params[:id]).first()
  end
end
