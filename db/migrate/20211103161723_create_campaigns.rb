class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.integer :dm_id

      t.timestamps
    end
  end
end
