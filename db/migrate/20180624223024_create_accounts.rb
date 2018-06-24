class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, limit: 50
      t.references :tenant, foreign_key: true
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
