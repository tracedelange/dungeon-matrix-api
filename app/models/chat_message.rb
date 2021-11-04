class ChatMessage < ApplicationRecord
    belongs_to :campaign
    belongs_to :author, :class_name => "User"

    after_create_commit do
        messages = Campaign.find(self.campaign_id).chat_messages
        ChatMessageCreationEventBroadcastJob.perform_later({type: 'new_message', chat_messages: ActiveModel::Serializer::CollectionSerializer.new(messages, each_serializer: ChatMessageSerializer)}.to_json, self.campaign_id)
    end
end
