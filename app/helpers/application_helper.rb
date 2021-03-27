module ApplicationHelper
  def default_description
    "Wicked Queer, Boston's LGBTQ+ Film Festival is the fourth oldest
    LGBTQ+ film festival in North America and the largest LGBTQ+ media
    event in New England. The 37th Festival will take place virtually
    throughout April 2021."
  end

  def formatted_title(title = nil)
    tit = [title, 'Wicked Queer', "Boston's LGBTQ+ Film Festival"]
    tit = tit.reject{ |t| t.empty? }
    tit.join(' | ')
  end

  def formatted_date(date)
    date&.strftime('%B %-d, %l:%M %p')
  end

  def formatted_cost(cost)
    format("$%.2f", cost)
  end
end
