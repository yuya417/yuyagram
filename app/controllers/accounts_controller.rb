class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @profile = @user.profile
    @articles = @user.articles.order("id DESC")
    user_judgement(@user)
    @post_counts = @user.post_counts(@user)
    @follower_counts = @user.follower_counts(@user)
    @following_counts = @user.following_counts(@user)
  end

  private
  def user_judgement(user)
    if user == current_user
      redirect_to edit_profile_path
    end
  end

end