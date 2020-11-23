class ProfilesController < ApplicationController 

  def show
    @account = current_user.account_name
  end

  
end