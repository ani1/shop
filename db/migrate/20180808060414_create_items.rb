class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :rate, null: false
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
