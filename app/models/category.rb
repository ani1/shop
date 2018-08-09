class Category < ApplicationRecord
  has_many :items, :dependent => :destroy

  validates :name, presence: true, length: { in: 1..80 }, uniqueness: { case_sensitive: false }
end
