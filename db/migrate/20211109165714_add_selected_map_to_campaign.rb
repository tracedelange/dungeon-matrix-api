class AddSelectedMapToCampaign < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :selected_map_id, :integer
  end
end
