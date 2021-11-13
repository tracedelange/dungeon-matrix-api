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

    def updateCharacterHealth(opts)

      character = Character.find(opts.fetch('character_id'))
      character.update(health: opts.fetch('health'))

      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)

    end

    def updateUserPosition(opts)
      map_character =  MapCharacter.find(opts.fetch('map_character_id'))
      map_character.update(position_x: opts.fetch('position_x'), position_y: opts.fetch('position_y'))

      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)
    end

    def generateMap(opts)


      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)

      puts params[:gridConfiguration][:width]
      for n in 0...20 do
        
        MapElement.create(map_id: current_map.id, avatar_index: 4, position_x: rand(params[:gridConfiguration][:width]), position_y:rand(params[:gridConfiguration][:height]) )
        # MapElement.create(map_id: current_map.id, avatar_index: opts.fetch('avatar_index'), position_x: opts.fetch('position_x'), position_y: opts.fetch('position_y'))

      end

      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)

    end

    
    def spawnElement(opts)
      
      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      
      
      MapElement.create(map_id: current_map.id, avatar_index: opts.fetch('avatar_index'), position_x: opts.fetch('position_x'), position_y: opts.fetch('position_y'))
      
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)
    end
    
    def clearMap
      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      
      elements = MapElement.where(map_id: current_map.id )
      elements.each {|element| element.delete }
      
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)


    end

    def spawnUser(opts)
      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      
      current_map.map_characters.create(position_x: 0, position_y:0, character_id: opts.fetch('characterID'), user_id: opts.fetch('userID') )
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)
      

    end

    def getSessionData()
      campaign = Campaign.find(params[:id])
      current_map = Map.find(campaign.selected_map_id)
      SessionJoinGetDataEvent.perform_later(params[:id], {type: 'map_data', map_data: ActiveModelSerializers::SerializableResource.new(current_map, {serializer: MapSerializer})}.to_json)
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