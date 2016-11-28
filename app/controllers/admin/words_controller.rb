class Admin::WordsController < ApplicationController
  before_action :verify_login, :verify_admin
  before_action :load_all_category, only: [:new, :create]

  def index
    params[:search] ||= ""
    @words = Word.list_word
      .all_words(current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.word.per_page
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.create word_params
    if @word.save
      flash[:success] = t "word_sucessful"
      redirect_to :back
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:content, :is_correct, :_destroy]
  end
end
