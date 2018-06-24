class AddApplicationToTenant < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :application, :string, limit: 50
  end
end
