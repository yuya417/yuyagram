class UnfollowsController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:account_id])
    follow_status = current_user.has_followed?(user)
    render json: { followStatus: follow_status }
  end

  def create
    current_user.unfollow!(params[:account_id])
    render json: { status: 'ok' }
  end

end