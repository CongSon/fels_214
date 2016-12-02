class UsersController < ApplicationController
  before_action :verify_login, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]
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
    @activities = Activity.user_activity(@user.id).limit(Settings.activity.size)
    @lessons = @user.lessons.paginate page: params[:page],
      per_page: Settings.lesson.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash[:notice] = t ".update_fail"
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end
end
