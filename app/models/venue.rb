class Venue < ContentfulModel::Base
  self.content_type_id = 'venue'

  belongs_to_many :events

  return_nil_for_empty :name, :url, :location, :virtual, :description

  def analytics_attributes
    {
      name: name,
      url: url,
      location: location,
      virtual: virtual
    }
  end
end
