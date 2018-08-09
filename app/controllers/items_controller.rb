class ItemsController < ApplicationController

  before_action :set_category, only: [:new, :create]
  before_action :set_item, only: [:destroy]

  def index
    @cat_ids = index_params[:categories_selection][:ids] if index_params[:categories_selection].present?
    @items = Item.where(category_id: index_params[:categories_selection][:ids]).preload(:category, :item_taxes) if @cat_ids.present?
  end

  def new
    @item = @category.items.new
  end

  def create
    @item = @category.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_item_taxes_url(@item), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to items_url(categories_selection: {ids: params[:categories_selection][:ids]}), notice: 'Category was successfully Deleted.' }
      else
        format.html { redirect_to items_url(categories_selection: {ids: params[:categories_selection][:ids]}), notice: 'Category was not Deleted.' }
      end
    end
  end

  private

  def set_category
    @category = Category.find params[:category_id]
  end

  def set_item
    @item = Item.find params[:id]
  end

  def item_params
    params.require(:item).permit(:name, :rate)
  end

  def index_params
    params.permit(categories_selection: [ids: []])
  end
end
