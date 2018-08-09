class Item < ApplicationRecord
  belongs_to :category
  has_many :item_taxes, :dependent => :destroy

  validates :name, presence: true, length: {in: 1..80}, uniqueness: {scope: :category, message: "is already present in this category", case_sensitive: false}

  validates :rate, presence: true, numericality: { greater_than: 0}


  def total_tax
    self.item_taxes.map(&:amount).inject(:+) if self.item_taxes.any?
  end

  def grand_total
    rate + total_tax if total_tax.present?
  end
end