class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:account_id])
    @articles = @user.articles.all.order("id DESC")
  end

end