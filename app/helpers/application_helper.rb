module ApplicationHelper
  def formatted_title(title)
    "#{title + ' | ' unless title.empty?}Wicked Queer"
  end

  def formatted_date(date)
    date&.strftime('%B %-d, %Y  %l:%M %p')
  end

  def formatted_cost(cost)
    format("$%.2f", cost)
  end
end
