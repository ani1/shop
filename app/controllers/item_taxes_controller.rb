class ItemTaxesController < ApplicationController

  before_action :set_item, only: [:new, :create, :index]
  before_action :set_item_tax, only: [:destroy]

  def index
    @item_taxes = @item.item_taxes

  end

  def new
    @item_tax = @item.item_taxes.new
  end

  def create
    @item_tax = @item.item_taxes.new(item_tax_params)

    respond_to do |format|
      if @item_tax.save
        format.html { redirect_to item_item_taxes_url(@item), notice: 'Item Tax was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @item_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item_tax.destroy
        format.html { redirect_to item_item_taxes_url, notice: 'Item Tax  was successfully Deleted.' }
      else
        format.html { redirect_to item_item_taxes_url, notice: 'Item Tax was not Deleted.' }
      end
    end

  end

  private

  def set_item
    @item = Item.find params[:item_id]
  end

  def set_item_tax
    @item_tax = ItemTax.find params[:id]
  end

  def item_tax_params
    params.require(:item_tax).permit(:tax_name, :tax_type, :tax)
  end
end
