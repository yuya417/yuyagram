class ProfilesController < ApplicationController
  before_action :authenticate_user!

  # def show
  #   article = Article.find(params[:article_id])
  #   @user = article.user
  #   @profile = @user.profile
  # end

  def edit
    @user = current_user
    @profile = current_user.prepare_profile
    @articles = @user.articles
  end

  def update
    @profile = current_user.prepare_profile
    @profile.id = current_user.id
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to edit_profile_path, notice: 'プロフィール更新！'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:image)
  end

end
