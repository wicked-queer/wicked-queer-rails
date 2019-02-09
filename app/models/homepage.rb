class HomePage < ContentfulModel::Base
  self.content_type_id = 'homePage'

  return_nil_for_empty :url
end
