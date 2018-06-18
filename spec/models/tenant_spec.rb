require 'rails_helper'

RSpec.describe Tenant, type: :model do

  describe 'Tenant' do
    it 'should create a new tenant' do
      tenant = build :tenant
      expect(tenant.valid?).to eq(true)
    end
  end
end
