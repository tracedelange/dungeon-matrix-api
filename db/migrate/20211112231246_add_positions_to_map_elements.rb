class AddPositionsToMapElements < ActiveRecord::Migration[6.1]
  def change
    add_column :map_elements, :position_x, :integer
    add_column :map_elements, :position_y, :integer
  end
end
