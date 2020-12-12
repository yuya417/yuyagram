class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :account_name, :author_image

  def author_image
    if object.author_image != 'Ellipse.png'
      rails_blob_path(object.author_image) 
    else
      "/assets/Ellipse-e92648f5df99b7de1b6d306f6c928151e854e73295e6836f20c1f6d52df38acc.png"
    end
  end

end