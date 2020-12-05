class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :set_profile

  def index
    @articles = Article.all.order("id DESC")
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
    @article.profile = @profile
    if @article.save!
      redirect_to root_path, notice: '保存しました！'
    else
      flash.now[:error] = '保存できませんでした'
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

  def set_profile
    if current_user.profile.present?
      @profile = current_user.profile
    else
      redirect_to profile_path
    end
  end

end