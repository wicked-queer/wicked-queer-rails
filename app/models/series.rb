class Series < ContentfulModel::Base
  self.content_type_id = 'series'

  belongs_to_many :events

  return_nil_for_empty :name, :description

  def analytics_attributes
    {
      name: name,
      description: description
    }
  end
end
