class SubscriptionListsController < ApplicationController
  before_action :find_model
  before_action :find_client

  def index
    @subscription_lists = @client.subscription_lists
  end

  def new
    @subscription_list = SubscriptionList.new( client: @client )
  end

  def show

  end

  def create
    @subscription_list = SubscriptionList.new(subscription_list_params)
    if@subscription_list.save
      redirect_to subscription_lists_path( :client => @client)
      flash[:notice] = "Subscription List successfully created!"
    else
      render :new
    end
  end

  private
  def find_model
    @model = SubscriptionList.find(params[:id]) if params[:id]
  end

  def find_client
    @client = Client.find(params[:client]) if params[:client]
  end

  def subscription_list_params
    params.require(:subscription_list).permit( :name, :list_type, :client_id )
  end


end
