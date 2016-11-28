class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :p_name
      t.decimal :p_price
      t.integer :p_num
      t.integer :p_salNum
      t.integer :con

      t.timestamps
    end
  end
end
