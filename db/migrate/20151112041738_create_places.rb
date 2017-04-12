class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
