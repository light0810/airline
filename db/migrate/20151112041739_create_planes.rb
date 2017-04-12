class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :name
      t.string :code
      t.integer :status, default: 0, null: false
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
