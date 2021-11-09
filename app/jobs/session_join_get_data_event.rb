class SessionJoinGetDataEvent < ApplicationJob

    queue_as :default
      
    def perform(id, sessionData)
  
      # ChatChannel.broadcast_to('chat_message:1', chat_message)
      
      ActionCable.server.broadcast("chat_channel_#{id}", sessionData)
  
    end
  end