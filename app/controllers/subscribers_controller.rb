class SubscribersController < ApplicationController
  before_action :find_list, :find_client

  def add
    @manual = ManualSubscribersImporter.new
  end

  def add_manual
    cv_string = params[:manual_subscribers_importer][:csv_string]
  end

  def clear
    @list.subscribers.delete_all
    flash[:notice] = "List successfully cleared!"
    redirect_to subscription_list_path(@list, :client => @client)
  end


  private
  def manual_params
    params.require(:manualsubscriberimporter).permit(:csv_string)
  end

  def find_list
    @list = SubscriptionList.find(params[:list]) if params[:list]
  end

  def find_client
    @client = Client.find(params[:client]) if params[:client]
  end
end
