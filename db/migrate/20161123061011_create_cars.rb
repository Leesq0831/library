class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.integer :c_num
      t.integer :con
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
