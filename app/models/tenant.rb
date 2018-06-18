class Tenant < ApplicationRecord
  validates_presence_of :name
end
