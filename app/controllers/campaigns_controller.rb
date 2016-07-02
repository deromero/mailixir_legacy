class CampaignsController < ApplicationController

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      redirect_to campaign_path @campaign
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description)
  end


end
