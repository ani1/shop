require 'rails_helper'

describe ItemTaxesController do

  let(:category) { create(:category, name: 'Foo') }

  let(:item) { create(:item, name: 'Bar', rate: 200, category: category) }

  let(:item_tax1) { create(:item_tax, tax_name: 'Tax1', tax_type: 'percentage', tax: 10, item: item) }

  let(:item_tax2) { create(:item_tax, tax_name: 'Tax2', tax_type: 'value', tax: 30, item: item) }

  describe 'GET #index' do
    it 'lists item taxes of specific item' do
      get :index, {item_id: item.id}
      expect(response).to be_success
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new item_tax to @item_tax' do
      get :new, {item_id: item.id}
      expect(assigns(:item_tax)).to be_a_new(ItemTax)
    end
  end

  describe 'POST #create' do
    it "creates a new item tax" do
      params = {tax_name: 'Tax1', tax_type: 'percentage', tax: 10}
      expect{
        post :create, {item_tax: params}.merge({item_id: item.id})
      }.to change(ItemTax,:count).by(1)
    end

    it "redirects to the item taxes page" do
      params = {tax_name: 'Tax1', tax_type: 'percentage', tax: 10}
      post :create, {item_tax: params}.merge({item_id: item.id})
      response.should redirect_to "/items/#{item.id}/item_taxes"
    end
  end
end