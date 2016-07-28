class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to client_path @client
      flash[:notice] = "Client #{@client.name} successfully created!"
    else
      render :new
    end

  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update_attributes(client_params)
      redirect_to client_path @client
      flash[:notice] = "Client #{@client.name} successfully updated!"
    else
      render :edit
    end

  end


  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name, :contact_name, :contact_email,
                                   :country_code, :time_zone)
  end

end
