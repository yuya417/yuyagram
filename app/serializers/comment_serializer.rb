class CommentSerializer < ActiveModel::Serializer
  attributes :id, :article_id, :user_id, :content

  belongs_to :user
  belongs_to :profile
end
