class ProfilesController < ApplicationController 

  def show
    @account = current_user.account_name
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.prepare_profile
  end




  
end