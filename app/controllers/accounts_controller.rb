class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @profile = @user.profile
    @articles = @user.articles.order("id DESC")
    if @user == current_user
      redirect_to edit_profile_path
    end
  end
end