class CharactersController < ApplicationController
    before_action :set_current_user


    def index
        characters = Character.where(user_id: @user.id)
        render json: characters, status: :ok
    end

    def create

        newCharacter = @user.characters.create(name: params[:name], avatar_index: params[:avatar_index], maxhealth: params[:health], health: params[:health])

        if newCharacter.valid?

            render json: newCharacter
        else
            render json: newCharacter.errors, status: :unprocessable_entity
        end

    end


    def destroy
        character = @user.characters.find_by(id: params[:id])
        if character

            character.destroy
            if character.destroyed?
                head :no_content
            else
                render json: {error: 'There was an error while deleting this character'}
            end
        else
            render json: {error: "Either this character does not exist or you don't have permission to delete it."}
        end

    end

end
