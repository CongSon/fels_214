class UsersController < ApplicationController
  def index
    params[:search] ||= ""
    @users = User.find_all_user
      .send(Settings.all_users, params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end
end
