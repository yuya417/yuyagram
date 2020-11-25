class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @articles = Article.all.order("id DESC")
    @profile = current_user.profile
    @account = current_user.account_name
  end
  
  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    @profile = current_user.profile
    @article.profile_id = @profile.id
    if @article.save!
      redirect_to root_path, notice: '保存しました！'
    else
    
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end


  private
  def article_params
    params.require(:article).permit(:content, :images)
  end

end