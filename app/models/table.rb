class Table < ApplicationRecord
  validates :name, uniqueness: true
end
