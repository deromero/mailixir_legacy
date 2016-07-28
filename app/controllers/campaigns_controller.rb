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

  def edit
    find_by_id
  end

  def update
    find_by_id

    if @campaign.update_attributes(campaign_params)
      redirect_to campaign_path @campaign
      flash[:notice] = "Campaign #{@campaign.name} successfully updated!"
    else
      render :edit
    end
  end

  def show
    find_by_id

    if @campaign.is_draft?
      redirect_to build_campaign_path @campaign
    end

  end

  def build
    find_by_id
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :subject, :client, :client_id,
                                     :from_email, :from_name, :reply_to,
                                     :send_report_to)
  end

  def find_by_id
    @campaign = Campaign.find(params[:id])
  end

end
