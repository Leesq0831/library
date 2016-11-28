class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :author
      t.string :p_place
      t.year :p_time
      t.integer :p_num
      t.string :langugae
      t.integer :format
      t.string :introduce
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
