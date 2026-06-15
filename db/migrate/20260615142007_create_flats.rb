class CreateFlats < ActiveRecord::Migration[8.1]
  def change
    create_table :flats do |t|
      t.string :name
      t.text :description
      t.string :address
      t.integer :price_by_night
      t.integer :capacity
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
