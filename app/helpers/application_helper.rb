module ApplicationHelper
  def formatted_title(title)
    "#{title + ' | ' unless title.empty?}Wicked Queer"
  end

  def image_with_default(url)
    url ? url : image_path('static.gif')
  end
end
