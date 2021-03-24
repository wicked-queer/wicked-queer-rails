class Venue < ContentfulModel::Base
  self.content_type_id = 'venue'

  belongs_to_many :events

  return_nil_for_empty :name, :url, :location, :virtual, :description

  def to_hash
    {
      name: name,
      url: url,
      location: location,
      virtual: virtual
    }
  end

  def to_json
    to_hash.to_json
  end
end
