class UsersController < ApplicationController
  def index
    @page_header = 'Users'
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @page_header = "#{@user.name}'s Profile"
  end
end
