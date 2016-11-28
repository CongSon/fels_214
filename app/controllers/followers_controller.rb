class FollowersController < ApplicationController
  before_action :load_user, :verify_login
  def show
    @followers = @user.followers
    @users = @followers.paginate page: params[:page],
      per_page: Settings.follower.per_page
  end
end
