require 'rails_helper'

RSpec.describe AccountItem, type: :model do

  let :tenant do
    Tenant.first || create( :tenant )
  end

  let :table do
    create( :table, tenant: tenant )
  end

  let :account do
    create :account, tenant: tenant, table: table
  end

  let :product do
    create :product, tenant: tenant
  end


  before :each do
    tenant
  end

  describe 'smoke test' do
    it 'foo' do
      account_item = build :account_item, account: account, tenant: tenant, product: product
      expect(account_item.valid?).to eq(true)
    end
  end
end
