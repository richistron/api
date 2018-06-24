class AccountItem < ApplicationRecord
  belongs_to :product
  belongs_to :tenant
  belongs_to :account
end
