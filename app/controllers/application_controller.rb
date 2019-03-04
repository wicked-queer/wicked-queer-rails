class ApplicationController < ActionController::Base
  helper ContentfulRails::MarkdownHelper

  def check_preview_api
    if ENV['USE_PREVIEW_API']
      ContentfulModel.use_preview_api = true
    end
  end
end
