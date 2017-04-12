class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :location
      t.integer :level, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.integer :price, default: 0, null: false
      t.references :plane, index: true, foreign_key: true
      t.references :flight, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
