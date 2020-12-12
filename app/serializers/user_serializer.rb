class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :account_name, :author_image

  # def author_image
  #   if object.author_image.attached?
  #     rails_blob_path(object.author_image) 
  #   else
  #     rails_blob_path("file:///Users/yuya/yuyagram/app/assets/images/Ellipse.png") 
  #   end
  # end

end