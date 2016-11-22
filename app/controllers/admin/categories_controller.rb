class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_category_success"
      redirect_to root_path
    else
      flash.now[:danger] = t ".create_category_fail"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
