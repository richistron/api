class Account < ApplicationRecord
  belongs_to :tenant
  belongs_to :table
  has_many :account_items

  def total
    account_items.map { |a| a.product.price }.inject(0) { |sum, x| sum += x}
  end
end
