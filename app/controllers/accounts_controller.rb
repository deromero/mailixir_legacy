class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :signin, :search]

  def new
     @account = Account.new
     @account.build_owner
  end

  def create
    @account = Account.new(account_params)
    if @account.valid?
      Apartment::Database.create(@account.subdomain)
      Apartment::Database.switch(@account.subdomain)

      @account.save
      redirect_to new_user_session_url(subdomain: @account.subdomain)
    else
      render :new
    end
  end

  def signin
    @search_account = AccountSearch.new
  end

  def search
    account_subdomain = params[:account_search][:subdomain]

    if Account.exists?(subdomain: account_subdomain)
      @account = Account.find_by subdomain: account_subdomain
      redirect_to new_user_session_url(subdomain: @account.subdomain)
    else
      @search_account = AccountSearch.new(subdomain: account_subdomain)
      flash[:error] = "account does not exists!"
      #redirect_to sign_in_url(subdomain: false)
      render :signin
    end
  end

private
  def account_params
    params.require(:account).permit(:subdomain, owner_attributes: [:name, :email, :password, :password_confirmation])
  end

end
