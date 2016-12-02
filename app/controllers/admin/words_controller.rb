class Admin::WordsController < ApplicationController
  before_action :verify_login, :verify_admin
  before_action :load_all_category, except: [:show, :destroy]
  before_action :load_word, except: [:index, :new, :create]
  layout "admin"

  def index
    params[:search] ||= ""
    @words = Word.list_word.in_category(params[:category_id])
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
      redirect_to admin_words_path
    else
      render :new
    end
  end

  def show
    @answers = @word.answers
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".update_success"
    else
      flash[:notice] = t ".update_failed"
    end
    redirect_to admin_words_path
  end

  def destroy
    if @word.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "fail_to_delete"
    end
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
