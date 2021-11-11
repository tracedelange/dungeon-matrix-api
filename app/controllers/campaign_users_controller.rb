class CampaignUsersController < ApplicationController

    before_action :set_current_user

    # def index
    #     if params[:campaign_id]
    #         campaign = Campaign.find_by(id: params[:campaign_id])

    #         if campaign
    #             render json: campaign.campaign_users, status: :ok
    #         else
    #             render json: {error: 'Campaign Not found.'}, status: :unprocessable_entity
    #         end
    #     else
    #         render json: {error: 'Campaign ID required for index query.'}, status: :unprocessable_entity
    #     end

    # end

    def create
        user = User.find_by(username: params[:username])
        campaign = Campaign.find_by(id: params[:campaign_id])

        if user && campaign
            # create relationship
            campaign.users << user
            render json: campaign.users, status: :created
        else
            render json: {error: "User or campaign not found."}
        end
        
    end
    
    def destroy        
        user = User.find_by(id: params[:user_id])
        campaign = Campaign.find_by(id: params[:campaign_id])
        if user && campaign

            if @user.id == campaign.dm_id || @user.id == user.id
                join_instance = CampaignUser.find_by(campaign_id: campaign.id, user_id: user.id)
                join_instance.destroy
                if join_instance.destroyed?
                    head :no_content
                else
                    render json: {error: "There was a problem removing user from campaign."}
                end
            else
                render json: {error: "You dont have permission to remove this user from the campaign."}
            end
        else
            render json: {error: "User or campaign not found."}
        end
    end

    private

    def campaign_users_params(params)
        params.permit(:campaign_id, :username)
    end


end
