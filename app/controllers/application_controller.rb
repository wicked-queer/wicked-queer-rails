class ApplicationController < ActionController::Base
  helper ContentfulRails::MarkdownHelper

  def check_preview_api
    unless Rails.env.production?
      ContentfulModel.use_preview_api = true
    end
  end
end
