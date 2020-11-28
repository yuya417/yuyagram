class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :account_name, uniqueness: true
  has_one :profile, dependent: :destroy

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy


  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end

end
