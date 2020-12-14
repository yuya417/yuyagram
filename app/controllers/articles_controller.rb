class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all.order("id DESC")
    @user = current_user
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = @article.comments.build
  end
  
  def new
    @article = current_user.articles.build
    @article.profile_id = current_user.id
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.profile_id = current_user.id
    @profile = current_user.profile
    if @article.save!
      redirect_to root_path, notice: 'Saved!'
    else
      flash.now[:error] = 'Could not be saved'
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!
  end


  private
  def article_params
    params.require(:article).permit(:content, images: [])
  end

end