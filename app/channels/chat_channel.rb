class ChatChannel < ApplicationCable::Channel
    def subscribed
      stream_from "chat_channel_#{params[:id]}"
    end
  
    def unsubscribed
      puts 'unsubscribing'
    end
  
    def create(opts)
      ChatMessage.create(
        author_id: params[:user_id],
        campaign_id: params[:id],
        content: opts.fetch('content')
      )
    end

    
    def newUserConnected(opts)
        joinedUser = User.find(params[:user_id])
        ChatMessage.create(
          author_id: 3700,
          campaign_id: params[:id],
          content: joinedUser.username + ' has joined the chat.'
        )
    end
    def userHasLeft(opts)
        leftUser = User.find(params[:user_id])
        ChatMessage.create(
          author_id: 3700,
          campaign_id: params[:id],
          content: leftUser.username + ' has left the chat.'
        )
    end
  end