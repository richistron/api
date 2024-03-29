class V1::TablesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant
  before_action :set_table, only: [:show, :update, :destroy]

  # GET /tables
  def index
    @tables = Table.where tenant: @tenant

    render json: @tables
  end

  # GET /tables/1
  def show
    render status: :not_found if @table.nil?
    render json: @table
  end

  # POST /tables
  def create
    @table = Table.new(table_params)
    @table.tenant = @tenant

    if @table.save
      render json: @table, status: :created, location: v1_table_path(@table)
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tables/1
  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tables/1
  def destroy
    @table.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.where(id: params[:id], tenant: @tenant).first
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      params.require(:table).permit(:name)
    end

    def set_tenant
      @tenant = current_user.tenant
    end

end
