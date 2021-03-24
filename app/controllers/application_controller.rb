class ApplicationController < ActionController::Base
  helper ContentfulRails::MarkdownHelper

  before_action :set_gon_variables

  def check_preview_api
    if ENV['USE_PREVIEW_API']
      ContentfulModel.use_preview_api = true
    end
  end

  def set_gon_variables
    gon.event = {}
  end
end
