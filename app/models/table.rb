class Table < ApplicationRecord
  validates_presence_of :tenant_id, :name

  validates :name, uniqueness: { scope: :tenant_id }
  belongs_to :tenant
end
