class AddTenantToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :tenant, foreign_key: true
  end
end
