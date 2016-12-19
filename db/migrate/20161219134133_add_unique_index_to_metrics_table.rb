class AddUniqueIndexToMetricsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :metrics, [:driver_id, :metric_name, :timestamp], :unique => true
  end
end
