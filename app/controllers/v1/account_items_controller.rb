class V1::AccountItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant
  before_action :set_account_item, only: [:show, :update, :destroy]

  # GET /account_items
  def index
    @account_items = AccountItem.where tenant: @tenant

    render json: @account_items
  end

  # GET /account_items/1
  def show
    render status: :not_found if @account_item.nil?
    render json: @account_item
  end

  # POST /account_items
  def create
    @account_item = AccountItem.new(account_item_params)
    @account_item.tenant = @tenant

    if @account_item.save
      render json: @account_item, status: :created, location: v1_account_item_path(@account_item)
    else
      render json: @account_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /account_items/1
  def update
    if @account_item.update(account_item_params)
      render json: @account_item
    else
      render json: @account_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /account_items/1
  def destroy
    # TODO implement destroy method only for admins
    # @account_item.destroy
    render json: @account_item
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account_item
    @account_item = AccountItem.where(id: params[:id], tenant: @tenant).first
  end

  # Only allow a trusted parameter "white list" through.
  def account_item_params
    params.require(:account_item).permit(:account_id, :product_id)
  end

  def set_tenant
    @tenant = current_user.tenant
  end

end
