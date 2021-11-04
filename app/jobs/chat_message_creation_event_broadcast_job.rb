class ChatMessageCreationEventBroadcastJob < ApplicationJob

    queue_as :default
      
    def perform(chat_messages, id)
  
      # ChatChannel.broadcast_to('chat_message:1', chat_message)
      
      ActionCable.server.broadcast("chat_channel_#{id}", chat_messages)
  
    end
  end