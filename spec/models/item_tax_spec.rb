require 'rails_helper'

RSpec.describe ItemTax, :type => :model do

  it { should validate_presence_of :tax_name}
  it { should validate_presence_of :tax_type}
  it { should validate_presence_of :tax}
  it { should belong_to :item }

  it {should validate_length_of(:tax_name).is_at_least(1)}
  it {should validate_length_of(:tax_name).is_at_most(80)}

  it {should_not allow_value('xxx').for(:tax_type) }
  it {should allow_value('percentage').for(:tax_type) }
  it {should allow_value('value').for(:tax_type) }

  it { should validate_numericality_of(:tax) }
  it { should_not allow_value(-1).for(:tax) }
  it { should allow_value(0).for(:tax) }
  it { should allow_value(1).for(:tax) }

  let(:category) do
    FactoryBot.create(:category, name: 'Foo')
  end

  describe 'amount' do
    it 'should give correct tax amount' do
      item = category.items.create(name: 'Bar', rate: 10)
      item_tax1 = item.item_taxes.create(tax_name: 'GST', tax_type: 'percentage', tax: 50)
      item_tax2 = item.item_taxes.create(tax_name: 'Prof Tax', tax_type: 'value', tax: 15)
      expect(item_tax1.amount).to eq 5.00
      expect(item_tax2.amount).to eq 15.00
    end
  end

end