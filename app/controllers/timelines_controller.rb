class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    user_ids = current_user.followings.pluck(:id)
    @articles = Article.where(user_id: user_ids, created_at: 24.hours.ago..Time.now).left_joins(:likes).group(:id).order('COUNT(likes.id) DESC').limit(5)
    @user = current_user
  end


end