class Product < ApplicationRecord
  validates_presence_of :price, :name
  validates_numericality_of :price
  belongs_to :tenant
end
