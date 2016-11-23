class Admin::UsersController < ApplicationController
  before_action :verify_login, :verify_admin

  def index
    params[:search] ||= ""
    @users = User.find_all_user
      .all_users(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end
end
