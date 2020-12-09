class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @profile = current_user.prepare_profile
    @articles = @user.articles.order("id DESC")
  end

  def edit
    @user = current_user
    @profile = current_user.prepare_profile
    @articles = @user.articles.order("id DESC")
    @post_counts = @user.post_counts(@user)
    @follower_counts = @user.follower_counts(@user)
    @following_counts = @user.following_counts(@user)
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
