class HomeController < ApplicationController
  def show
    @campaigns = Campaign.all
  end
end
