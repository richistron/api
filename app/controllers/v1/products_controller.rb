class V1::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /account_items
  def index
    @products = Product.where tenant: @tenant

    render json: @products
  end

  # GET /account_items/1
  def show
    render status: :not_found if @product.nil?
    render json: @product
  end

  # POST /account_items
  def create
    @product = Product.new(product_params)
    @product.tenant = @tenant

    if @product.save
      render json: @product, status: :created, location: v1_product_path(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /account_items/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /account_items/1
  def destroy
    @product.destroy
    render json: {}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.where(id: params[:id], tenant: @tenant).first
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(:price, :name)
  end

  def set_tenant
    @tenant = current_user.tenant
  end

end
