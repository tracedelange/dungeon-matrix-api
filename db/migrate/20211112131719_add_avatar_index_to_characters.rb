class AddAvatarIndexToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :avatar_index, :integer, default: 1
  end
end
