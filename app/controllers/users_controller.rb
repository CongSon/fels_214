class UsersController < ApplicationController
  def index
    params[:search] ||= ""
    @users = User.find_all_user
      .all_users(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] =t ".welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
