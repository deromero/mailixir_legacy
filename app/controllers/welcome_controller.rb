class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @page_css_class = 'page-home'

  end
end
