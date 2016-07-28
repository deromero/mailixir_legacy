class RecipientsController < ApplicationController
  before_action :find_campaign

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  private
  def find_campaign
    @campaign = Campaign.find(params[:campaign]) if params[:campaign]
  end

end
