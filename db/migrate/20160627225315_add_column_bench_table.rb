class AddColumnBenchTable < ActiveRecord::Migration
  def change
    add_column :benches, :seating, :string
  end
end
