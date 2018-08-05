class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :buyer_id
      t.integer :product_id
      t.float :price
      t.integer :amount
      t.integer :supplier_id
      t.string :file

      t.timestamps
    end
  end
end
