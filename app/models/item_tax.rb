class ItemTax < ApplicationRecord
  belongs_to :item

  # enum tax_type: [:percentage, :value]

  validates :tax, :tax_name, :tax_type, presence: true
  validates :tax, numericality: {greater_than_or_equal_to: 0}
  validates :tax_name, length: { in: 1..80 }, uniqueness: {scope: :item, message: "is already present in this item", case_sensitive: false}
  validates :tax_type, inclusion: { in: %w(percentage value), message: "%{value} is not a valid tax type" }

  def amount
    self.tax_type == 'percentage' ? (self.tax.to_f/100)*self.item.rate : self.tax
  end
end
