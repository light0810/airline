class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :code
      t.integer :status, default: 0, null: false
      t.date :start_time
      t.date :end_time
      t.integer :start_place_id
      t.integer :end_place_id
      t.integer :cooldown_date, default: 1, null: false
      t.integer :number_ticket_1, default: 50, null: false
      t.integer :number_ticket_2, default: 50, null: false
      t.integer :number_ticket_3, default: 50, null: false
      t.integer :number_ticket_other, default: 0, null: false
      t.integer :price_ticket_1, default: 10, null: false
      t.integer :price_ticket_2, default: 10, null: false
      t.integer :price_ticket_3, default: 10, null: false
      t.integer :price_ticket_other, default: 0, null: false
      t.references :plane, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
