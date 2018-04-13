class CreateMagazines < ActiveRecord::Migration[5.2]
  def change
    create_table :magazines do |t|
      t.string :name
      t.integer :year
      t.string :month
      t.string :cover
      t.string :condition
      t.text :notes
      t.integer :user_id
    end
  end
end
