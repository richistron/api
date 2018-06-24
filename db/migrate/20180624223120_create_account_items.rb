class CreateAccountItems < ActiveRecord::Migration[5.2]
  def change
    create_table :account_items do |t|
      t.references :product, foreign_key: true
      t.references :tenant, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
