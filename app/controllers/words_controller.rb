class WordsController < ApplicationController
  before_action :load_all_category, only: [:index]
  def index
    params[:search] ||= ""
    @words = Word.list_word
      .all_words(params[:search])
      .paginate page: params[:page], per_page: Settings.word.per_page
  end
end
