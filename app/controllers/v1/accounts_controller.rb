class V1::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.where tenant: @tenant

    render json: @accounts.map {|a| a.as_json.merge({total: a.total })}
  end

  # GET /accounts/1
  def show
    render status: :not_found if @account.nil?
    render json: @account.as_json.merge({total: @account.total})
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.tenant = @tenant

    if @account.save
      render json: @account.as_json.merge({total: @account.total}), status: :created, location: v1_account_path(@account)
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account.as_json.merge({total: @account.total})
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    # TODO implement destroy method only for admins
    # @account.destroy
    render json: @account
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.where(id: params[:id], tenant: @tenant).first
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:name, :table_id)
  end

  def set_tenant
    @tenant = current_user.tenant
  end

end
