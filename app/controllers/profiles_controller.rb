class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @profile = current_user.profile
  end

  def edit
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    @profile.id = current_user.id
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新！'
    else
      flash.now[:error] = '更新できませんでした'
      render :show
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:image)
  end

end
