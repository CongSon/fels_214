class Admin::WordsController < ApplicationController
  before_action :load_all_category, only: [:new, :create]

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

  def load_all_category
    @category = Category.select :name, :id
  end
end
