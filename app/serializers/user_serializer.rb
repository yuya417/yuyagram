class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :account_name, :author_image

  # def author_image
  #   rails_blob_path(object.author_image) if object.author_image.attached?
  # end

end