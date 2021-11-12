class CreateMapElements < ActiveRecord::Migration[6.1]
  def change
    create_table :map_elements do |t|
      t.integer :map_id
      t.integer :avatar_index

      t.timestamps
    end
  end
end
