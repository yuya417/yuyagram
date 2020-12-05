class CommentRelationshipMailer < ApplicationMailer

  def comment_reply(to_user, from_user, content)
    @to_user = to_user
    @from_user = from_user
    @content = content
    mail to: to_user.email, subject: '【お知らせ】コメントが届いています！'
  end

end