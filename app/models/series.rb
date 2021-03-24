class Series < ContentfulModel::Base
  self.content_type_id = 'series'

  belongs_to_many :events

  return_nil_for_empty :name, :description

  def to_hash
    {
      name: name,
      description: description
    }
  end

  def to_json
    to_hash.to_json
  end
end
