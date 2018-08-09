require 'rails_helper'

describe ItemsController do

  let(:category) { create(:category, name: 'Foo') }

  let(:item) { create(:item, name: 'Bar', rate: 100, category: category) }

  describe 'GET #index' do
    it 'lists items of selected catagories' do
      get :index, {categories_selection: {ids: [category.id]}}
      expect(response).to be_success
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new item to @item' do
      get :new, {category_id: category.id}
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe 'POST #create' do
    it "creates a new item" do
      params = {name: 'ItemBar', rate: 200}
      expect{
        post :create, {item: params}.merge({category_id: category.id})
      }.to change(Item,:count).by(1)
    end

    it "redirects to the item taxes page" do
      params = {name: 'ItemBar', rate: 200}
      post :create, {item: params}.merge({category_id: category.id})
      response.should redirect_to "/items/#{Item.last.id}/item_taxes"
    end
  end
end