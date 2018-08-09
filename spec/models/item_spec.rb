require 'rails_helper'

RSpec.describe Item, :type => :model do

  it { should validate_presence_of :name}
  it { should validate_presence_of :rate}
  it { should have_many(:item_taxes).dependent(:destroy) }
  it { should belong_to :category }

  it {should validate_length_of(:name).is_at_least(1)}
  it {should validate_length_of(:name).is_at_most(80)}

  it { should validate_numericality_of(:rate) }
  it { should_not allow_value(-1).for(:rate) }
  it { should_not allow_value(0).for(:rate) }
  it { should allow_value(1).for(:rate) }

  let(:category) do
    FactoryBot.create(:category, name: 'Foo')
  end

  describe 'name uniqueness' do

    it "should have a unique name" do
      category.items.create!(name: 'bar', rate: 100)
      item_dup = category.items.new(name: 'Bar', rate: 10)
      expect(item_dup).to be_invalid
      item_dup.errors[:name].should include("is already present in this category")
    end
  end

  describe 'total_tax and grand_total' do
    it "should calculate total tax" do
      item = category.items.create(name: 'Bar', rate: 100)
      item.item_taxes.create([
          {tax_name: 'GST', tax_type: 'percentage', tax: 5},
          {tax_name: 'Prof Tax', tax_type: 'value', tax: 15},
          {tax_name: 'VAT', tax_type: 'percentage', tax: 10}
      ])
      expect(item.total_tax).to eq 30.00
      expect(item.grand_total).to eq 130.00
    end
  end
end