class Table < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, length: { minimum: 1, maximum: 150 }
end
