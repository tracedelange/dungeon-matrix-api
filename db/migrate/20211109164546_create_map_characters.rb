class CreateMapCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :map_characters do |t|
      t.integer :map_id
      t.integer :position_x
      t.integer :position_y

      t.timestamps
    end
  end
end
