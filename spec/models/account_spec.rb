require 'rails_helper'

RSpec.describe Account, type: :model do

  let :tenant do
    Tenant.first || create( :tenant )
  end

  let :table do
    create( :table, tenant: tenant )
  end

  before :each do
    table
  end

  describe 'valid account' do
    it 'all gucci' do
      account = build :account, tenant: tenant, table: table
      expect(account.valid?).to eq(true)
    end
  end

  describe 'invalid account' do
    it 'no tenant' do
      account = build :account, table: table
      expect(account.valid?).to eq(false)
    end

    it 'no table' do
      account = build :account, tenant: tenant
      expect(account.valid?).to eq(false)
    end
  end
end
