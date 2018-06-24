class Tenant < ApplicationRecord
  validates_presence_of :name, :application
  validates_uniqueness_of :name
end
