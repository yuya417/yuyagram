class Article < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  has_many_attached :images

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

end
