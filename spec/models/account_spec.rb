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

  describe 'account.total' do
    it 'total amount' do
      account = create :account, tenant: tenant, table: table
      product = Product.create! price: 1, tenant: tenant, name: 'cliche de bolita'
      expect(account.valid?).to be(true)

      AccountItem.create! account: account, product: product, tenant: tenant
      AccountItem.create! account: account, product: product, tenant: tenant
      expect(account.total).to be(2.0)
    end
  end
end
