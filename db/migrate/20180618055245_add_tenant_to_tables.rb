class AddTenantToTables < ActiveRecord::Migration[5.2]
  def change
    add_reference :tables, :tenant, foreign_key: true
  end
end
