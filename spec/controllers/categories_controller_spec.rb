require 'rails_helper'

describe CategoriesController do

  let(:category) { create(:category, name: 'Foo') }

  describe 'GET #new' do
    it 'assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'GET #edit' do
    it 'assigns given category to @category' do
      get :edit, {id: category.id}
      expect(assigns(:category)).to eq category
    end
  end

  describe 'GET #index' do
    it "shows all categories" do
      get :index
      response.should render_template :index
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    it "creates a new category" do
      params = {name: 'Bar'}
      expect{
        post :create, category: params
      }.to change(Category,:count).by(1)
    end

    it "redirects to the categories page" do
      params = {name: 'Bar'}
      post :create, category: params
      response.should redirect_to :categories
    end
  end

  describe 'PUT #update' do
    it "updates a category" do
      params = {name: 'Bar'}
      put :update, {category: params}.merge({id: category.id})
      category.reload
      expect(category.name).to eql params[:name]
    end

    it "redirects to the categories page" do
      params = {name: 'Bar'}
      put :update, {category: params}.merge({id: category.id})
      response.should redirect_to :categories
    end
  end

  describe 'DELETE #destroy' do
    it "redirects to the categories page" do
      delete :destroy, {id: category.id}
      response.should redirect_to :categories
    end
  end

end