class Admin::UsersController < ApplicationController
  before_action :verify_login, :verify_admin
  before_action :load_user, only: :destroy
  layout "admin"

  def index
    params[:search] ||= ""
    @users = User.find_all_user
      .all_users(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "fail_to_delete"
    end
    redirect_to :back
  end
end
