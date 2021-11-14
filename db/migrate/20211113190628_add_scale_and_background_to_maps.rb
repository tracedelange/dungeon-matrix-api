class AddScaleAndBackgroundToMaps < ActiveRecord::Migration[6.1]
  def change
    add_column :maps, :width, :integer, default: 25
    add_column :maps, :height, :integer, default: 25
    add_column :maps, :tile_index, :integer, default: 1
    add_column :maps, :background_index, :integer, default: 1
  end
end
