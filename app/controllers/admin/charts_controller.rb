require "common"
class Admin::ChartsController < ApplicationController
  layout "admin"

  include SharedMethods
  def index
    @user_accounts = []
    @lessons = []
    count_users
    count_lessons
    @user_accounts.reverse!
    @lessons.reverse!

    respond_to do |format|
      format.html
      format.json {
        render json: [
          {type: t("column"), name: t("user_account"),
            data: @user_accounts,
            tooltip: {valueSuffix: t("user")}},
          {type: t("column"), name: t("lesson_count"),
            data: @lessons,
            tooltip: {valueSuffix: t("lesson")}}
        ]
      }
    end
  end

  private
  def count_users
    current_date = get_current_monday - Settings.one.day
    Settings.weekday.times.each do |day|
      @user_accounts << User.user_count(current_date
        .strftime(Settings.date_format))
      current_date = current_date - Settings.one.day
    end
  end

  def count_lessons
  current_date = get_current_monday - Settings.one.day
    Settings.weekday.times.each do |day|
      @lessons << Lesson.lesson_count(current_date
        .strftime(Settings.date_format))
      current_date = current_date - Settings.one.day
    end
  end
end
