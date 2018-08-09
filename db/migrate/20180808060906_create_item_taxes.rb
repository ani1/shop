class CreateItemTaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :item_taxes do |t|
      t.references :item, foreign_key: true
      t.decimal :tax
      t.string :tax_name
      t.string :tax_type

      t.timestamps
    end
  end
end
