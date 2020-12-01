class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]

  def index
    article = Article.find(params[:article_id])
    @comments = article.comments
    @comment = article.comments.build
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    @comment.save!
    redirect_to article_comments_path(article)
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


end