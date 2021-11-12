class AddHealthToCharacters < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :health, :integer, default: 1
    add_column :characters, :maxHealth, :integer
  end
end
