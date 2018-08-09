require 'rails_helper'

RSpec.describe Category, :type => :model do

  it { should validate_presence_of :name}
  it { should have_many(:items).dependent(:destroy) }

  it {should validate_length_of(:name).is_at_least(1)}
  it {should validate_length_of(:name).is_at_most(80)}

  describe 'name uniqueness' do
    it "should have a unique name" do
      Category.create!(name: 'foo')
      category_dup = Category.new(name: 'Foo')
      expect(category_dup).to be_invalid
      category_dup.errors[:name].should include("has already been taken")
    end
  end
end