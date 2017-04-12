class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :email_paypal
      t.integer :price
      t.string :transaction_id
      t.datetime :purchased_at
      t.text :notification_params
      t.string :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
