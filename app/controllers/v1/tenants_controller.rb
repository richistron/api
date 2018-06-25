class V1::TenantsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_account_item, only: [:show, :update, :destroy]

  # GET /tenants
  def index
    @tenant = Tenant.all

    render json: @tenant
  end

  # GET /tenants/1
  def show
    render status: :not_found if @tenant.nil?
    render json: @tenant
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      render json: @tenant, status: :created, location: v1_tenant_path(@tenant)
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tenants/1
  def update
    if @tenant.update(tenant_params)
      render json: @tenant
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy
    render json: {}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account_item
    @tenant = Tenant.find params[:id]
  end

  # Only allow a trusted parameter "white list" through.
  def tenant_params
    params.require(:tenant).permit(:name, :application)
  end

end
