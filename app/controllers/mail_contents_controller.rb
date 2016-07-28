class MailContentsController < ApplicationController
  before_action :find_campaign

  def new
    @mail_content = MailContent.new( campaign: @campaign)
  end

  def create
    @mail_content = MailContent.new(mail_content_params)

    if @mail_content.save
      redirect_to campaign_path @campaign
      flash[:notice] = "Content successfully created!"
    else
      render :new
    end

  end

  def edit
    @mail_content = MailContent.find(params[:id])
  end

  def update
    @mail_content = MailContent.find(params[:id])

    if @mail_content.update_attributes(mail_content_params)
      redirect_to campaign_path @campaign
      flash[:notice] = "Content successfully updated!"
    else
      render :edit
    end

  end

  private
  def find_campaign
    @campaign = Campaign.find(params[:campaign]) if params[:campaign]
  end

  def mail_content_params
    params.require(:mail_content).permit(:html_content, :text_content, :campaign_id)
  end

end
