class AddUserIdToMapCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :map_characters, :user_id, :integer
  end
end
