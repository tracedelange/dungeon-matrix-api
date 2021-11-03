class CampaignsController < ApplicationController
    before_action :set_current_user


    def index #return all campaigns in which the user is either a member or DM
        campaigns = @user.campaigns
        render json: campaigns, status: :ok
    end

    def create
        newCampaign = @user.campaigns.create(title: campaign_params[:title], dm_id: @user.id)
        if newCampaign.valid?
            render json: newCampaign, status: :created
        else
            render json: newCampaign.errors, status: :unprocessable_entity
        end
    end

    def show
        campaign = @user.campaigns.find_by(id: params[:id])
        if campaign
            render json: campaign
        else
            render json: {error: "Campaign doesnt exist or you dont have access."}, status: 404
        end
    end

    def update
        campaign = @user.campaigns.find_by(dm_id: @user.id, id: params[:id])
        if campaign
            campaign.update(campaign_params) #could allow for DM's to transfer ownership relativly easily
            if campaign.valid? 
                render json: campaign, status: :ok
            else
                render json: campaign.errors, status: :unprocessable_entity
            end
        else
            render json: {error: "Campaign doesnt exist or you dont have update rights."}, status: 404
        end

    end

    def destroy
        campaign = @user.campaigns.find_by(dm_id: @user.id, id: params[:id])

        if campaign
            campaign.destroy
            if campaign.destroyed?
                head :no_content
            else
                render json: {errors: "Campaign could not be deleted."}, status: :unprocessable_entity
            end 
        else
            render json: {error: "You dont have permission to delete this campaign."}, status: :unprocessable_entity
        end


    end

    private

    def campaign_params
        params.permit(:title, :dm_id)
    end

    # campaign_index GET    /campaign(.:format)                                                                campaign#index
    # POST   /campaign(.:format)                                                                               campaign#create
    # campaign GET    /campaign/:id(.:format)                                                                  campaign#show
    # PATCH  /campaign/:id(.:format)                                                                           campaign#update
    # PUT    /campaign/:id(.:format)                                                                           campaign#update
    # DELETE /campaign/:id(.:format)                                                                           campaign#destroy



end
