class AddCharacterIdToMapCharacter < ActiveRecord::Migration[6.1]
  def change
    add_column :map_characters, :character_id, :integer
  end
end
