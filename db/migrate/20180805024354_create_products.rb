class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
