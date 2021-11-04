class AddUsersConnectedToCampaign < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :connected_count, :integer, default: 0
  end
end
