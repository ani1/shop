class CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: 'Category was successfully Updated.' }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to categories_url, notice: 'Category was successfully Deleted.' }
      else
        format.html { redirect_to categories_url, notice: 'Category was not Deleted.' }
      end
    end

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end