class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      redirect_to campaign_path @campaign
      flash[:notice] = "Campaign #{@campaign.name} successfully created!"
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :subject, :client, :client_id,
                                     :from_email, :from_name, :reply_to,
                                     :send_report_to)
  end


end
