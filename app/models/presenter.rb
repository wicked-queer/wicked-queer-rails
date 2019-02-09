class Presenter < ContentfulModel::Base
  self.content_type_id = 'coPresenter'

  belongs_to_many :events

  return_nil_for_empty :presenter_name, :presenter_logo, :presenter_url
end
