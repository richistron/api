class AddNameToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :name, :string, limit: 50
  end
end
