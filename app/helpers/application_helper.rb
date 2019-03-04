module ApplicationHelper
  def formatted_title(title)
    "#{title + ' | ' unless title.empty?}Wicked Queer"
  end
end
