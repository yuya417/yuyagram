class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  
  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments, include: { user: [ :profile] }
  end


  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    comment_reply
    render json: @comment, include: { user: [ :profile] }
  end

  def destroy
    article = Article.find(params[:article_id])
    @comment = article.current_user.comments
    @comment.destroy!
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def comment_reply
    users = User.all
    users.each do |user|
      @to_name = user.account_name
      @from_name = @comment.user.account_name
      if @comment.content.include?("@#{@to_name}")
        @content = @comment.content.gsub(/\@#{@to_name}/,"#{@to_name}")
        CommentRelationshipMailer.comment_reply(user, @from_name, @content).deliver_later
        @comment.save!
      else
        @comment.save!
      end
    end
  end

end