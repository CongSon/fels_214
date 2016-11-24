class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def verify_login
    unless logged_in?
      store_location
      flash[:danger] = t "must_login"
      redirect_to login_url
    end
  end

  def verify_admin
    redirect_to(root_url) unless current_user.is_admin?
  end

  protected
  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
