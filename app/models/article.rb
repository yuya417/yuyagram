class Article < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  has_many_attached :images

  def author_name
    user.account_name
  end

  def author_img 
    user.profile.image
  end

end
