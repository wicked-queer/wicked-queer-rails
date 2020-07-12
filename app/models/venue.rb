class Venue < ContentfulModel::Base
  self.content_type_id = 'venue'

  belongs_to_many :events

  return_nil_for_empty :name, :url, :location, :virtual
end
