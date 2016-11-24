class Admin::CsvController < ApplicationController
  def index
    @words = Word.order(:created_at)
    respond_to do |format|
      format.html
      format.csv {send_data @words.export, filename: "words-#{Date.today}.csv"}
    end
  end

  def create
    Word.import params[:file]
    redirect_to root_url, notice: I18n.t(".word_imported")
  end
end
