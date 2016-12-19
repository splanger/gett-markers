class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.string :metric_name
      t.integer :value
      t.decimal :lat, precision: 20, scale: 3
      t.decimal :lon, precision: 20, scale: 3
      t.datetime :timestamp
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
