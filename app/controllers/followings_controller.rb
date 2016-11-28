class FollowingsController < ApplicationController
  before_action :load_user, :verify_login
  def show
    @following = @user.following
    @users = @following.paginate page: params[:page],
      per_page: Settings.following.per_page
  end
end
