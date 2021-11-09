class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.text :content
      t.integer :campaign_id
      t.integer :author_id

      t.timestamps
    end
  end
end
