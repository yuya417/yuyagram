class Article < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  has_many_attached :images
end
