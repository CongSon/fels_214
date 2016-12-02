class Admin::PieChartController < ApplicationController
  layout "admin"

  def index
    marks = Lesson.mark_ladder
    respond_to do |format|
      format.html
      format.json {
        render json: [
          {name: t("ratio"),
          colorByPoint: true,
          data: marks}
        ]
      }
    end
  end
end
