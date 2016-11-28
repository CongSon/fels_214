class Admin::CategoriesController < ApplicationController
  before_action :load_category, except: [:create, :index, :new]

  def index
    params[:search] ||= ""
    @categories = Category.order(created_at: :ASC)
      .send(Settings.all_categories, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_category_success"
    else
      flash[:notice] = t ".create_category_fail"
    end
    redirect_to :back
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update_success"
    else
      flash[:notice] = t ".update_failed"
    end
    redirect_to :back
  end

  def destroy
    if @category.words.any?
      flash[:notice] = t ".notice_message"
    elsif @category.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:notice] = t ".delete_fail"
    end
    redirect_to :back
  end

  private
  def category_params
    params.permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    render_404 unless @category
  end
end
